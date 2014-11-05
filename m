From: monstr@monstr.eu (Michal Simek)
Date: Wed, 05 Nov 2014 09:32:01 +0100
Subject: [GIT PULL] Xilinx Zynq fix for v3.18
Message-ID: <5459E081.8000903@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

please add this fix to your tree.

Thanks,
Michal


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-fixes-for-3.18

for you to fetch changes up to 2de4752d6923d7dcc6e68c23be6a52d5f0896f9d:

  ARM: zynq: Actually remove hotplug.c (2014-10-20 20:53:26 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq fix for v3.18

- Remove unused hotplug.c file

----------------------------------------------------------------
Soren Brinkmann (1):
      ARM: zynq: Actually remove hotplug.c

 arch/arm/mach-zynq/Makefile  |  2 --
 arch/arm/mach-zynq/hotplug.c | 14 --------------
 2 files changed, 16 deletions(-)
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/f3ea9850/attachment.sig>
