# FFmpeg 소스 코드 (GPL v3)

HADA 콘텐츠 스튜디오 Windows 설치판에는 숏폼 영상을 만들 때 쓰는 **FFmpeg 실행 파일**이 수정 없이 들어 있습니다.
FFmpeg는 GNU General Public License version 3(GPL v3)로 배포되며, 이 폴더는 그 소스 코드를 받을 수 있게 둔 곳입니다.

| 항목 | 내용 |
|---|---|
| 실행 파일 | FFmpeg **6.1.1** `essentials_build` — www.gyan.dev (Windows x64) |
| 실행 파일 출처 | [eugeneware/ffmpeg-static](https://github.com/eugeneware/ffmpeg-static) `b6.1.1` (npm `ffmpeg-static` 5.3.0) |
| 빌드 설정 | `--enable-gpl --enable-version3 --enable-static` … (앱 안 `THIRD-PARTY-NOTICES.txt`에 전체 기록) |
| 소스 | [`ffmpeg-6.1.1.tar.xz`](ffmpeg-6.1.1.tar.xz) — [ffmpeg.org](https://ffmpeg.org/releases/ffmpeg-6.1.1.tar.xz) 공식 배포본 그대로 |
| 서명 | [`ffmpeg-6.1.1.tar.xz.asc`](ffmpeg-6.1.1.tar.xz.asc) — FFmpeg release signing key로 서명 확인함 (2026-10-07) |
| SHA-256 | `8684f4b00f94b85461884c3719382f1261f0d9eb3d59640a1f4ac0873616f968` |

- 실행 파일에 함께 들어간 외부 라이브러리(x264·x265·libvpx 등)와 빌드 방법: https://www.gyan.dev/ffmpeg/builds/
- GPL v3 전문: 앱 안 `THIRD-PARTY-NOTICES.txt` 끝 · https://www.gnu.org/licenses/gpl-3.0.html
- HADA 콘텐츠 스튜디오 자체는 FFmpeg를 별도 프로그램으로 실행만 하며, FFmpeg와 하나의 프로그램으로 결합되어 있지 않습니다.

---

**English** — The HADA Content Studio Windows installer bundles an unmodified FFmpeg 6.1.1 executable (gyan.dev essentials build, GPL v3).
This folder provides the corresponding FFmpeg source (official ffmpeg.org tarball, signature verified). Build details and bundled libraries: https://www.gyan.dev/ffmpeg/builds/
