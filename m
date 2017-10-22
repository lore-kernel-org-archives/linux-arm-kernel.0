From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 22 Oct 2017 03:38:05 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.15
Message-ID: <7hmv4jqxgy.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to 88b1b18ffeae1d65e22ec24040545a84c3ace352:

  ARM: dts: meson: add the SDIO MMC controller (2017-10-11 17:18:25 -0700)

----------------------------------------------------------------
Amlogkc 32-bit platforms: DT updates for v4.15
- add SDIO MMC controller
- reserved memory fixes
- SoC info driver nodes
- enable USB host contnroller

----------------------------------------------------------------
Emiliano Ingrassia (2):
      ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board
      ARM: dts: meson: fixing USB support on Meson6, Meson8 and Meson8b

Linus L?ssing (1):
      ARM: dts: meson8b: add reserved memory zone to fix silent freezes

Martin Blumenstingl (3):
      dt-bindings: Amlogic: add documentation for the SoC info register areas
      ARM: dts: meson: add SoC information nodes
      ARM: dts: meson: add the SDIO MMC controller

 Documentation/devicetree/bindings/arm/amlogic/analog-top.txt | 20 ++++++++++++++++++++
 Documentation/devicetree/bindings/arm/amlogic/assist.txt     | 17 +++++++++++++++++
 Documentation/devicetree/bindings/arm/amlogic/bootrom.txt    | 17 +++++++++++++++++
 arch/arm/boot/dts/meson.dtsi                                 | 23 +++++++++++++++++++++--
 arch/arm/boot/dts/meson8.dtsi                                | 11 +++++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts                       | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi                               | 23 +++++++++++++++++++++++
 7 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/analog-top.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/assist.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/bootrom.txt
