From: monstr@monstr.eu (Michal Simek)
Date: Wed, 30 Jul 2014 13:39:12 +0200
Subject: [GIT PULL] Xilinx Zynq dt changes for v3.17 - third pull request
Message-ID: <53D8D960.3030302@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

I didn't expect that I will get patches for Parallella board
but it will be worth to have them in. That's why please consider
to pull these patches to your arm-soc trees.

The branch is based on zynq/dt2 branch in arm-soc git repo
http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/log/?h=zynq/dt2

Thanks,
Michal


The following changes since commit e0a5c552caf7a4865f3d5aa077003ef2d35217db:

  ARM: zynq: DT: Add GPIO node (2014-07-23 14:05:56 +0200)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-for-3.17-3

for you to fetch changes up to 6a3246c02e7bcb16a58f3fcee4662a9b36ea80e9:

  ARM: zynq: DT: Clarify Xilinx Zynq platform (2014-07-30 13:26:54 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.17 third pull request

- Add Adapteva Parallella board/DT
- Add SPI nodes
- Add CAN nodes
- Clean Zynq description

----------------------------------------------------------------
Andreas F?rber (5):
      Documentation: devicetree: Adapteva vendor prefix
      Documentation: devicetree: Adapteva boards
      ARM: dts: zynq: Add Parallella device tree
      ARM: dts: zynq: Add DMAC for Parallella
      ARM: dts: zynq: Add SPI

Michal Simek (2):
      ARM: zynq: DT: Add CAN node
      ARM: zynq: DT: Clarify Xilinx Zynq platform

Soren Brinkmann (1):
      ARM: zynq: DT: Remove DMA from board DTs

 Documentation/devicetree/bindings/arm/adapteva.txt    |  7 +++++++
 Documentation/devicetree/bindings/arm/xilinx.txt      |  8 ++++----
 Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
 arch/arm/boot/dts/Makefile                            |  4 +++-
 arch/arm/boot/dts/zynq-7000.dtsi                      | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/zynq-parallella.dts                 | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc702.dts                      |  4 ++++
 7 files changed, 148 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
 create mode 100644 arch/arm/boot/dts/zynq-parallella.dts


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/068b39da/attachment.sig>
