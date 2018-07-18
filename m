From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 18 Jul 2018 16:10:14 +0200
Subject: [GIT PULL] arm: zynq: Xilinx DT changes for v4.19
Message-ID: <50ac449c-2196-0352-0352-1f761d321e61@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull the following patches.

Thanks,
Michal


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-v4.19

for you to fetch changes up to 7df89642f143d67a80605ea3fb7e53bcb95f6b39:

  arm: zynq: Remove #address/#size-cells from gpio-keys (2018-07-17
16:57:29 +0200)

----------------------------------------------------------------
arm: zynq: DT changes for v4.19

- Add Z-turn board
- Add mmc aliases
- Fix model information
- Sort out documentatio
- Update Zybo Z7
- Fix gpio-keys

----------------------------------------------------------------
Anton Gerasimov (1):
      arm: dts: zynq: Add support for Z-turn board

Luis Araneda (9):
      arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
boards
      arm: dts: zynq: correct and improve the model property of dt files
      dt-bindings: xilinx: zynq: Improve boards description
      dt-bindings: xilinx: zynq: Sort entries alphabetically
      dt-bindings: Move Paralella board to Xilinx
      dt-bindings: xilinx: zynq: Add missing boards
      arm: dts: zynq: Fix memory size on the Zybo Z7 board
      arm: dts: zynq: Use gpio constants for the Zybo Z7 board
      arm: dts: zynq: Add LEDs to the Zybo Z7 board

Michal Simek (2):
      arm: zynq: Add mmc alias for zc702/zc706/zed/zybo
      arm: zynq: Remove #address/#size-cells from gpio-keys

 Documentation/devicetree/bindings/arm/adapteva.txt |   7 -------
 Documentation/devicetree/bindings/arm/xilinx.txt   |  30
+++++++++++++++++++++++++-----
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/zynq-cc108.dts                   |   2 +-
 arch/arm/boot/dts/zynq-microzed.dts                |   4 ++--
 arch/arm/boot/dts/zynq-parallella.dts              |   2 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |   5 ++---
 arch/arm/boot/dts/zynq-zc706.dts                   |   3 ++-
 arch/arm/boot/dts/zynq-zc770-xm010.dts             |   2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts             |   2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts             |   2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts             |   2 +-
 arch/arm/boot/dts/zynq-zed.dts                     |   5 +++--
 arch/arm/boot/dts/zynq-zturn.dts                   | 114
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zybo-z7.dts                 |  16 +++++++++++++---
 arch/arm/boot/dts/zynq-zybo.dts                    |   3 ++-
 16 files changed, 170 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
 create mode 100644 arch/arm/boot/dts/zynq-zturn.dts
