From: monstr@monstr.eu (Michal Simek)
Date: Thu, 19 Jul 2018 10:12:30 +0200
Subject: [GIT PULL v2] ARM: dts: zynq: Xilinx DT changes for v4.19
Message-ID: <f36dbbeb-059f-6042-ff83-10ae4187a96f@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Based on discussion with Olof all DT patches are using these prefixes.
ARM: dts: zynq:. dt-bindings changes were reviewed by Rob.

Please pull the following ARM DT patches.

Thanks,
Michal

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-v4.19-v2

for you to fetch changes up to 9153bf9fb5290cd91deefa99f2983a851f2ca5da:

  ARM: dts: zynq: Remove #address/#size-cells from gpio-keys (2018-07-19
10:08:52 +0200)

----------------------------------------------------------------
ARM: dts: zynq: DT changes for v4.19

- Add Z-turn board
- Add mmc aliases
- Fix model information
- Sort out documentatio
- Update Zybo Z7
- Fix gpio-keys

----------------------------------------------------------------
Anton Gerasimov (1):
      ARM: dts: zynq: Add support for Z-turn board

Luis Araneda (9):
      ARM: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
boards
      ARM: dts: zynq: correct and improve the model property of dt files
      dt-bindings: xilinx: zynq: Improve boards description
      dt-bindings: xilinx: zynq: Sort entries alphabetically
      dt-bindings: xilinx: zynq: Move Paralella board to Xilinx
      dt-bindings: xilinx: zynq: Add missing boards
      ARM: dts: zynq: Fix memory size on the Zybo Z7 board
      ARM: dts: zynq: Use gpio constants for the Zybo Z7 board
      ARM: dts: zynq: Add LEDs to the Zybo Z7 board

Michal Simek (2):
      ARM: dts: zynq: Add mmc alias for zc702/zc706/zed/zybo
      ARM: dts: zynq: Remove #address/#size-cells from gpio-keys

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


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/c91b5a66/attachment.sig>
