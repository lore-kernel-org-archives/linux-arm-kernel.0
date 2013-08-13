From: monstr@monstr.eu (Michal Simek)
Date: Tue, 13 Aug 2013 16:50:47 +0200
Subject: arm-soc: Xilinx Zynq cleanups for v3.12
Message-ID: <520A47C7.4050000@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull these cleanup patches to your tree.

Thanks,
Michal

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.12

for you to fetch changes up to 060968ff9fa1a56b22cc2454906a233d302b1bd2:

  arm: zynq: hotplug: Remove unreachable code (2013-08-13 16:09:12 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq cleanup patches for v3.12

This branch contains these fixes:
- SLCR cleanup
- 2 minor zynq pll fixes
- Hotplug cleanup

----------------------------------------------------------------
Soren Brinkmann (6):
      arm: zynq: slcr: Remove redundant header #includes
      arm: zynq: slcr: Clean up #defines
      arm: zynq: slcr: Use read-modify-write for register writes
      clk/zynq/pll: Fix documentation for PLL register function
      clk/zynq/pll: Use #defines for fbdiv min/max values
      arm: zynq: hotplug: Remove unreachable code

 arch/arm/mach-zynq/hotplug.c | 55 +++++--------------------------------------------------
 arch/arm/mach-zynq/slcr.c    | 45 +++++++++++++++++----------------------------
 drivers/clk/zynq/pll.c       | 18 +++++++++++++-----
 3 files changed, 35 insertions(+), 83 deletions(-)


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/d7e6b013/attachment.sig>
