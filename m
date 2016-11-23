From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 Nov 2016 14:23:34 -0800
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.10, round 2
Message-ID: <m2k2btx2c9.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here's a final round of arm64 DT changes for Amlogic family SoCs.

Please pull.

Thanks,

Kevin

The following changes since commit ab5b24fdd2d551ea729e8e19e47811a646260331:

  ARM64: dts: meson-gxbb-vega-s95: Add SD/SDIO/MMC and PWM nodes (2016-11-15 12:05:54 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to 3db317765fcd55808c782f38c0d3f1862a922c2a:

  ARM64: dts: meson-gxl: Add support for Nexbox A95X (2016-11-23 07:57:35 -0800)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.10, round 2
- new SoC support: S912/GXM series (8x A53)
- new boards: Nexbox A1 (S912), Nexbox A95X (S905X)
- resets for 2nd USB PHY

----------------------------------------------------------------
Martin Blumenstingl (1):
      ARM64: dts: meson-gxbb: add the USB reset also to the second USB PHY

Neil Armstrong (3):
      ARM64: dts: Add support for Meson GXM
      ARM64: dts: meson-gxm: Add support for the Nexbox A1
      ARM64: dts: meson-gxl: Add support for Nexbox A95X

 Documentation/devicetree/bindings/arm/amlogic.txt                                  |   8 +++
 arch/arm64/boot/dts/amlogic/Makefile                                               |   4 ++
 arch/arm64/boot/dts/amlogic/{meson-gxl-s905d-p23x.dtsi => meson-gx-p23x-q20x.dtsi} |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                                        |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts                              | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts                               |   3 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts                               |   3 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts                                | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts                                |  77 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts                                |  58 ++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi                                         | 114 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 643 insertions(+), 3 deletions(-)
 rename arch/arm64/boot/dts/amlogic/{meson-gxl-s905d-p23x.dtsi => meson-gx-p23x-q20x.dtsi} (97%)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
