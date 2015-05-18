From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 May 2015 15:12:39 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v4.2
Message-ID: <5559E547.6090109@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these two patches to your tree.

Thanks,
Michal

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.2

for you to fetch changes up to ef6ca1a84a3da9bf45d31399090153e00fc6cd68:

  ARM: zynq: Drop use of slcr_unlock in zynq_slcr_system_restart
(2015-05-18 14:46:37 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq SoC patches for v4.2

- Change SoC reset path
- Fix SLCR unlock scheme

----------------------------------------------------------------
Josh Cartwright (2):
      ARM: zynq: Use restart_handler mechanism for slcr reset
      ARM: zynq: Drop use of slcr_unlock in zynq_slcr_system_restart

 arch/arm/mach-zynq/common.c |  6 ------
 arch/arm/mach-zynq/common.h |  1 -
 arch/arm/mach-zynq/slcr.c   | 28 +++++++++++++++++++---------
 3 files changed, 19 insertions(+), 16 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150518/a12f3ec5/attachment.sig>
