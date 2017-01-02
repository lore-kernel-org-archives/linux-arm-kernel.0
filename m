From: monstr@monstr.eu (Michal Simek)
Date: Mon, 2 Jan 2017 14:35:12 +0100
Subject: [GIT PULL] ARM: Xilinx ZynqMP DT fixes for v4.10
Message-ID: <1f71e528-74b0-c160-783f-0e41bf189f5e@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these two fixes to your tree. Will be good to get them to
v4.10. If not possible, please queue them for 4.11.

Thanks,
Michal


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynmp-dt-fixes-for-4.10

for you to fetch changes up to c415f9e8304a1d235ef118d912f374ee2e46c45d:

  ARM64: zynqmp: Fix i2c node's compatible string (2017-01-02 14:14:36
+0100)

----------------------------------------------------------------
arm: Xilinx ZynqMP DT fixes for v4.10

- Fix dtc warnings
- Fix i2c compatible string

----------------------------------------------------------------
Michal Simek (1):
      ARM64: zynqmp: Fix W=1 dtc 1.4 warnings

Moritz Fischer (1):
      ARM64: zynqmp: Fix i2c node's compatible string

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170102/10564cf4/attachment.sig>
