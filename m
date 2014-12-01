From: monstr@monstr.eu (Michal Simek)
Date: Mon, 01 Dec 2014 09:38:02 +0100
Subject: [GIT PULL] Xilinx Zynq cleanups for v3.19
Message-ID: <547C28EA.50003@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these two cleanups patches to your tree.

Thanks,
Michal

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-cleanup-for-3.19

for you to fetch changes up to 2b175186fbdaa767327e743bd6215f709379272a:

  ARM: zynq: Remove secondary_startup() declaration from header (2014-12-01 09:32:22 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq cleanup patches for v3.19

- Remove unused file and declaration

----------------------------------------------------------------
Michal Simek (1):
      ARM: zynq: Remove secondary_startup() declaration from header

Soren Brinkmann (1):
      ARM: zynq: Actually remove hotplug.c

 arch/arm/mach-zynq/Makefile  |  2 --
 arch/arm/mach-zynq/common.h  |  1 -
 arch/arm/mach-zynq/hotplug.c | 14 --------------
 3 files changed, 17 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/hotplug.c


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/d6ccccf8/attachment.sig>
