From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Apr 2018 15:43:04 -0700
Subject: [GIT PULL] Amlogic fixes for v4.17-rc
Message-ID: <7hbmeg5e6f.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Technically, this is more "late" than "fixes", but I have excuses...

1) I was on vacation, but more importantly,
2) There were last minute driver issues that got sorted out after I sent
the main batch v4.17 DT pull requests.  Those issues (USB
suspend/resume) have now been sorted out and merged for v4.17-rc, so I'm
sending this series to enable USB for Amlogic.

This has been tested on Amlogic SoCs on top of v4.17-rc1.

Please pull for v4.17-rc,

Thanks,

Kevin

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes

for you to fetch changes up to 4b7b0d7b25538d2ad421a1041267d5208d3425bc:

  ARM64: dts: meson-gxm-khadas-vim2: enable the USB controller (2018-04-18 10:24:34 -0700)

----------------------------------------------------------------
Amlogic fixes for v4.17-rc1
- add / enable USB host support for GX boards

----------------------------------------------------------------
Martin Blumenstingl (7):
      ARM64: dts: meson-gxl: add USB host support
      ARM64: dts: meson-gxm: add GXM specific USB host configuration
      ARM64: dts: meson-gxl-s905x-p212: enable the USB controller
      ARM64: dts: meson-gx-p23x-q20x: enable the USB controller
      ARM64: dts: meson-gxl-s905x-libretech-cc: enable the USB controller
      ARM64: dts: meson-gxl-nexbox-a95x: enable the USB controller
      ARM64: dts: meson-gxm-khadas-vim2: enable the USB controller

 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts  |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi                   | 17 +++++++++++++++++
 7 files changed, 106 insertions(+)
