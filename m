From: monstr@monstr.eu (Michal Simek)
Date: Fri, 13 Dec 2013 09:33:47 +0100
Subject: arm-soc: Xilinx Zynq cleanups for v3.14
Message-ID: <52AAC66B.70404@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please pull these cleanup patches to your tree.

Thanks,
Michal


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.14

for you to fetch changes up to 2605f85275a7d5ccc5a59b05eed139656ad4e8a2:

  ARM: zynq: remove unnecessary setting of cpu_present_mask (2013-12-10 14:20:25 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq cleanup patches for v3.14

This branch contains these fixes:
- SMP cleanups
- platform initialization cleanup

----------------------------------------------------------------
Michal Simek (1):
      arm: zynq: Add support for zynq_cpu_kill function

Soren Brinkmann (4):
      arm: zynq: platsmp: Remove CPU presence check
      arm: zynq: Invalidate L1 in secondary boot
      arm: zynq: Use of_platform_populate instead of bus_probe
      arm: zynq: Set proper GIC flags

Sudeep KarkadaNagesha (1):
      ARM: zynq: remove unnecessary setting of cpu_present_mask

 arch/arm/mach-zynq/common.c  | 16 ++++++++++------
 arch/arm/mach-zynq/common.h  |  2 ++
 arch/arm/mach-zynq/headsmp.S |  6 +++++-
 arch/arm/mach-zynq/platsmp.c | 25 ++++++++++---------------
 4 files changed, 27 insertions(+), 22 deletions(-)


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131213/b3ca4690/attachment.sig>
