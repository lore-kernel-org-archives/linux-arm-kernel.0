From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 27 Sep 2018 12:05:24 +0200
Subject: [GIT PULL] arm64: dts: Amlogic updates for v4.20, round 2
Message-ID: <7h4leb45nf.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 445f2bda3501508b801b3571baee33de0ac44e1f:

  arm64: dts: meson: Switch simple-mfd and syscon order (2018-09-13 09:16:36 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to 9c8c52f7cb4f3b604bb9836947dadfbb255f465f:

  arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support (2018-09-26 02:04:58 -0700)

----------------------------------------------------------------
Amlogic ARM64 DT updates for v4.20, round 2
- new SoC support: basic support for G12A family
- new board: Amlogic U200 board, using G12A SoC
- fix SPI bus warnings from new dtc updates

----------------------------------------------------------------
Jianxin Pan (2):
      dt-bindings: arm: amlogic: Add Meson G12A binding
      arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support

Rob Herring (1):
      arm64: dts: meson: Fix erroneous SPI bus warnings

 Documentation/devicetree/bindings/arm/amlogic.txt |   6 +++
 arch/arm64/boot/dts/amlogic/Makefile              |   1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts   |  29 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi       |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        |   2 +-
 6 files changed, 210 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
