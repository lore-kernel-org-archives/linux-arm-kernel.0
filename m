From: monstr@monstr.eu (Michal Simek)
Date: Fri, 13 Dec 2013 09:33:53 +0100
Subject: arm-soc: Xilinx Zynq dt changes for v3.14
Message-ID: <52AAC671.6000207@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please pull these dt changes to your tree.

Thanks,
Michal


The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:

  Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-for-3.14

for you to fetch changes up to 41e4cdb95efa7e8fc88c65cb3c7221e89b9efb49:

  arm: dt: zynq: Add 'cpus' node (2013-12-12 09:50:23 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.14

- Add gem support
- Add cpus node
- TTC cleanup

----------------------------------------------------------------
Soren Brinkmann (2):
      arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
      arm: dt: zynq: Add 'cpus' node

Steffen Trumtrar (1):
      ARM: zynq: add gem support

 arch/arm/boot/dts/zynq-7000.dtsi | 39 +++++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/zynq-zc702.dts |  5 +++++
 arch/arm/boot/dts/zynq-zc706.dts |  5 +++++
 arch/arm/boot/dts/zynq-zed.dts   |  5 +++++
 4 files changed, 52 insertions(+), 2 deletions(-)


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131213/34badfe2/attachment.sig>
