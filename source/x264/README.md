# x264 소스 코드 (GPL v2 이상) — 맥 설치판용

HADA 콘텐츠 스튜디오 **맥(Mac) 설치판**에 들어 있는 FFmpeg 실행 파일은 저희가 직접 만든 것이며, 그 안에 **x264**(H.264 영상 압축)가 함께 묶여 있습니다.
x264는 GNU General Public License version 2 이상(GPL v2+)으로 배포되며, 이 폴더는 그 소스 코드와 만드는 방법을 받을 수 있게 둔 곳입니다.

| 항목 | 내용 |
|---|---|
| 소스 | [`x264-b35605a.tar.xz`](x264-b35605a.tar.xz) — [code.videolan.org/videolan/x264](https://code.videolan.org/videolan/x264) `stable` 브랜치 커밋 `b35605ace3ddf7c1a5d67a2eb553f034aef41d55` 그대로 (수정 없음) |
| SHA-256 | `f0da127ac50d90e9048a420fea914bb3cf4bf0e3b778e9e7b7af7d46aa76c563` |
| 함께 묶인 FFmpeg | FFmpeg **6.1.1** — 소스는 [`../ffmpeg/`](../ffmpeg/) (ffmpeg.org 공식 배포본, 수정 없음) |
| 만드는 방법 | [`build-ffmpeg-mac.sh`](build-ffmpeg-mac.sh) — 설치판을 만들 때 실제로 쓰는 스크립트 그대로 |
| FFmpeg 빌드 설정 | `--enable-gpl --enable-libx264 --enable-zlib --disable-autodetect --disable-network --disable-ffplay --disable-ffprobe` … (앱 안 `THIRD-PARTY-NOTICES.txt`에 전체 기록) |
| 대상 | macOS 11 이상 · 애플 칩(arm64) / 인텔(x86_64) 각각 |

- x264 라이선스 원문: 압축 파일 안 `COPYING` · https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
- HADA 콘텐츠 스튜디오 자체는 FFmpeg를 별도 프로그램으로 실행만 하며, FFmpeg와 하나의 프로그램으로 결합되어 있지 않습니다.
- 윈도우 설치판의 FFmpeg는 다른 곳(gyan.dev)에서 만든 것입니다 — [`../ffmpeg/README.md`](../ffmpeg/README.md) 참고.

---

**English** — The HADA Content Studio **macOS** installer bundles an FFmpeg 6.1.1 executable that we build ourselves, statically linked with x264 (GPL v2 or later).
This folder provides the corresponding x264 source (unmodified, commit `b35605a` of the `stable` branch) and the exact build script. FFmpeg source: [`../ffmpeg/`](../ffmpeg/).
