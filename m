From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 24 Mar 2016 11:05:11 -0700
Subject: [PATCH v2 0/4] ARM64: dts: amlogi: add a few more boards
Message-ID: <1458842715-27066-1-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for a few more Amlogic S905/GXBB based boards: Hardkernel
ODROID-C2 and Amlogic P200/P201 boards.

Series was boot tested on P200 and odroid-c2, on top of next-20160321.

Kevin Hilman (4):
  ARM64: dts: amlogic: update serial aliases
  Documentation: devicetree: amlogic: Document P20x and ODROID-C2 boards
  ARM64: dts: amlogic: add Hardkernel ODROID-C2
  ARM64: dts: amlogic: Add P200/P201 boards

 Documentation/devicetree/bindings/arm/amlogic.txt  |  3 +
 arch/arm64/boot/dts/amlogic/Makefile               |  3 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 69 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    | 52 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts    | 52 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   | 65 ++++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  4 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  5 --
 8 files changed, 248 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi

-- 
2.7.4
