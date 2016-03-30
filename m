From: carlo@caione.org (Carlo Caione)
Date: Wed, 30 Mar 2016 21:56:37 +0200
Subject: [GIT PULL] gxbb: DT64 changes for 4.7
Message-ID: <CAOQ7t2aOQ7svJZti+aLy4uyk37TGCYYCw3aHjBQvN6ysy6_vfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
new boards coming for 4.7, Odroid-C2 and the reference boards P200/P201.

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson tags/gxbb-dt64

for you to fetch changes up to ac40004db3fbea89c50083c6f9015ac7061e77b4:

  ARM64: dts: amlogic: Add P200/P201 boards (2016-03-30 19:52:34 +0200)

----------------------------------------------------------------
Add support for a few more Amlogic S905/GXBB based boards: Hardkernel ODROID-C2
and Amlogic P200/P201 boards.
We also fix the memory nodes on the Vega S95 DTS.

----------------------------------------------------------------
Andreas F?rber (1):
      ARM64: dts: amlogic: Clean up Vega S95 /memory nodes

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
 .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |  2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |  2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |  2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  4 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  5 --
 11 files changed, 251 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
