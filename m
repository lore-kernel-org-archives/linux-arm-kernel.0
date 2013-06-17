From: monstr@monstr.eu (Michal Simek)
Date: Mon, 17 Jun 2013 10:46:05 +0200
Subject: [GIT PULL] arm-soc: Xilinx Zynq DT changes for v3.11
Message-ID: <51BECCCD.5090104@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull the following device-tree changes to your arm-soc tree.
This tag is based on zynq/clk branch you have already added to arm-soc tree.

Thanks,
Michal

The following changes since commit 97c4e87d45498fb4d18c995721bba72345a7d257:

  clk: zynq: Remove deprecated clock code (2013-05-27 09:21:49 +0200)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-for-3.11

for you to fetch changes up to 50dbb4cfbc264b074759e8fb5d8e0c0496a1b072:

  arm: dt: zynq: Add support for the zed platform (2013-06-17 10:33:03 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt changes for v3.11

The branch contains:
- DT uart handling cleanup
- Support for zc706 and zed board
- Removal of board compatible string

----------------------------------------------------------------
Soren Brinkmann (4):
      arm: zynq: Remove board specific compatibility string
      arm: dt: zynq: Use 'status' property for UART nodes
      arm: dt: zynq: Add support for the zc706 platform
      arm: dt: zynq: Add support for the zed platform

 arch/arm/boot/dts/Makefile       |  4 +++-
 arch/arm/boot/dts/zynq-7000.dtsi |  2 ++
 arch/arm/boot/dts/zynq-zc702.dts |  6 +++++-
 arch/arm/boot/dts/zynq-zc706.dts | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zed.dts   | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-zynq/common.c      |  1 -
 6 files changed, 80 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-zc706.dts
 create mode 100644 arch/arm/boot/dts/zynq-zed.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/97e2763b/attachment.sig>
