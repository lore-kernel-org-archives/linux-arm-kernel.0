From: carlo@caione.org (Carlo Caione)
Date: Mon, 7 Mar 2016 13:21:07 +0100
Subject: Amlogic Meson ARM64 DTS changes for 4.6
Message-ID: <CAOQ7t2YQg01vdBQwQNWiij8A0j1Vr0Zyvj01gw+QZ1L8pSHHkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson.git tags/for-v4.6/gxbb-dt

for you to fetch changes up to cc733bc90636118b20aad8ce7421001b679b338a:

  ARM64: dts: amlogic: Add Tronsmart Vega S95 configs (2016-03-07
11:12:40 +0100)

----------------------------------------------------------------
This series adds initial support for the Amlogic S905 based
Tronsmart Vega S95 Pro, Meta and Telos TV boxes.

- Add new DTS to enable support for the boards
- Add documentation for compatibles and vendor prefix

----------------------------------------------------------------
Andreas F?rber (4):
      Documentation: devicetree: amlogic: Document Meson GXBaby
      ARM64: dts: Prepare configs for Amlogic Meson GXBaby
      Documentation: devicetree: amlogic: Document Tronsmart Vega S95 boards
      ARM64: dts: amlogic: Add Tronsmart Vega S95 configs

Matthias Brugger (1):
      devicetree: bindings: Add vendor prefix for Tronsmart

 Documentation/devicetree/bindings/arm/amlogic.txt  |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   7 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |  55 +++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |  55 +++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |  55 +++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  55 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 183 +++++++++++++++++++++
 9 files changed, 419 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/Makefile
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
