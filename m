From: monstr@monstr.eu (Michal Simek)
Date: Thu, 25 Feb 2016 14:12:53 +0100
Subject: [GIT PULL] ARM64: Xilinx ZynqMP DT changes for v4.6
Message-ID: <56CEFDD5.2090704@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these two patches to your tree.

Thanks,
Michal


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.6

for you to fetch changes up to 5087bccb2f184bad0abfb0b5840279f1540ed44c:

  ARM64: zynqmp: Extract clock information from EP108 (2016-02-25
14:01:03 +0100)

----------------------------------------------------------------
arm: Xilinx ZynqMP dt patches for v4.6

- Extract clock information from EP108
- Sort GPIO node

----------------------------------------------------------------
Michal Simek (2):
      ARM64: zynqmp: Keep gpio node alphabetically sorted
      ARM64: zynqmp: Extract clock information from EP108

 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi | 88
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts      |  1 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi           | 61
++++++++++---------------------------------------------------
 3 files changed, 99 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi


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
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/23dd89da/attachment-0001.sig>
