From: monstr@monstr.eu (Michal Simek)
Date: Thu, 09 Apr 2015 08:07:12 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v4.1
Message-ID: <55261710.5030407@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these two patches to your tree.

Thanks,
Michal

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.1

for you to fetch changes up to 6d07d722bbe0a2883a9b31130b0f0bb02f003d30:

  ARM: zynq: Drop use of slcr_unlock in zynq_slcr_system_restart
(2015-03-20 08:50:26 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq SoC patches for v4.1

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/c38f0592/attachment.sig>
