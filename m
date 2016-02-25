From: monstr@monstr.eu (Michal Simek)
Date: Thu, 25 Feb 2016 14:19:34 +0100
Subject: [GIT PULL] ARM32: Xilinx Zynq SoC changes for v4.6
Message-ID: <56CEFF66.2090907@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull these patches to your tree.

Thanks,
Michal

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.6

for you to fetch changes up to 8fff2f752f2c9d31414f83170157701b59aec4c1:

  ARM: zynq: Move early printk virtual address to vmalloc area
(2016-02-25 14:06:03 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq patches for v4.6

- SLCR early init
- Fix L2 cache data corruption
- Fix early printk uart setting

----------------------------------------------------------------
Josh Cartwright (2):
      ARM: zynq: initialize slcr mapping earlier
      ARM: zynq: address L2 cache data corruption

Michal Simek (1):
      ARM: zynq: Move early printk virtual address to vmalloc area

 arch/arm/include/debug/zynq.S | 4 ++--
 arch/arm/mach-zynq/common.c   | 3 +--
 arch/arm/mach-zynq/slcr.c     | 4 ++++
 3 files changed, 7 insertions(+), 4 deletions(-)



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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/68e5151c/attachment.sig>
