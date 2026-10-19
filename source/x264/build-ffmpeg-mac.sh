#!/usr/bin/env bash
# 맥용 ffmpeg 만들기 — 나눠 줘도 되는 판 (📦 배포 방, 2026-10-19)
#
# 왜: npm ffmpeg-static이 주는 맥용 ffmpeg는 '--enable-nonfree'로 만든 것 → FFmpeg 스스로 '재배포 불가'로 정한 판.
#     그래서 맥 설치 파일에는 우리가 직접 만든 ffmpeg를 넣는다.
# 무엇을: FFmpeg 6.1.1(윈도우판과 같은 버전) + x264(숏폼 영상 H.264 — lib/renderShort.ts가 libx264를 씀)
#     → GPL 판. nonfree 없음. 바깥 라이브러리는 맥 기본(zlib)만 — 교육생 맥에 따로 깔 게 없다.
#     원본 소스: 공개 저장소 source/ffmpeg(6.1.1) · source/x264 (GPL 6조 '소스 받는 곳')
# 쓰는 법: bash desktop/scripts/build-ffmpeg-mac.sh <작업폴더>   → <작업폴더>/out/bin/ffmpeg
#     지금 맥의 칩(arm64 / x86_64)용으로 만든다. GitHub에서는 칩별 맥에서 각각 돌린다.
set -euo pipefail
W="${1:?작업 폴더를 주세요}"
FFMPEG_VER=6.1.1
X264_REF="${X264_REF:-b35605ace3ddf7c1a5d67a2eb553f034aef41d55}"   # x264 stable 브랜치 (2026-10 확인) — 소스 공개용으로 고정
export MACOSX_DEPLOYMENT_TARGET=11.0   # macOS 11(Big Sur) 이상에서 돌게
mkdir -p "$W" && cd "$W"
P="$PWD/out"; mkdir -p "$P"
JOBS="$(sysctl -n hw.ncpu)"

if [ ! -f "$P/lib/libx264.a" ]; then
  [ -d x264 ] || { git clone https://code.videolan.org/videolan/x264.git x264 && git -C x264 checkout -q "$X264_REF"; }
  ( cd x264 && ./configure --prefix="$P" --enable-static --disable-cli --enable-pic --disable-opencl && make -j"$JOBS" && make install )
fi

# pkg-config가 없는 맥(이 PC)용 작은 대신 도구 — x264만 알면 된다 (GitHub 맥에는 원래 있음)
if ! command -v pkg-config >/dev/null; then
  mkdir -p "$W/shim"; cat > "$W/shim/pkg-config" <<SHIM
#!/bin/sh
case " \$* " in *" --version "*) echo 0.29.2; exit 0;; esac
for a in "\$@"; do case "\$a" in x264*) n=x264;; esac; done
[ "\$n" = x264 ] && [ -f "$P/lib/pkgconfig/x264.pc" ] || exit 1
case " \$* " in *" --modversion "*) grep '^Version:' "$P/lib/pkgconfig/x264.pc" | cut -d' ' -f2;; *" --cflags "*) echo "-I$P/include";; *" --libs "*) echo "-L$P/lib -lx264 -lpthread -lm";; esac
exit 0
SHIM
  chmod +x "$W/shim/pkg-config"; export PATH="$W/shim:$PATH"
fi

[ -f "ffmpeg-$FFMPEG_VER.tar.xz" ] || curl -sSLO "https://ffmpeg.org/releases/ffmpeg-$FFMPEG_VER.tar.xz"
[ -d "ffmpeg-$FFMPEG_VER" ] || tar xf "ffmpeg-$FFMPEG_VER.tar.xz"
( cd "ffmpeg-$FFMPEG_VER" && PKG_CONFIG_PATH="$P/lib/pkgconfig" ./configure --prefix="$P" \
    --enable-gpl --enable-libx264 --enable-zlib \
    --disable-autodetect --disable-network --disable-ffplay --disable-ffprobe --disable-doc --disable-debug \
    --pkg-config-flags=--static --extra-cflags="-I$P/include" --extra-ldflags="-L$P/lib" \
  && make -j"$JOBS" && make install )

B="$P/bin/ffmpeg"
"$B" -hide_banner -version | head -1
if "$B" -hide_banner -buildconf | grep -q -- "--enable-nonfree"; then echo "✖ nonfree가 들어갔어요"; exit 1; fi
"$B" -hide_banner -encoders 2>/dev/null | grep -q libx264 || { echo "✖ libx264가 없어요"; exit 1; }
# 맥 기본 라이브러리 말고 다른 걸 찾으면 교육생 맥에서 안 켜진다
if otool -L "$B" | tail -n +2 | grep -v -E "^\s+/(usr/lib|System/Library)/"; then echo "✖ 맥 기본이 아닌 라이브러리를 씁니다"; exit 1; fi
echo "✔ 맥용 ffmpeg 준비됨 ($(uname -m)) — $B"
