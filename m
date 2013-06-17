From: monstr@monstr.eu (Michal Simek)
Date: Mon, 17 Jun 2013 08:13:51 +0200
Subject: [GIT PULL] arm-soc: Xilinx Zynq cleanups for v3.11
Message-ID: <51BEA91F.2000305@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull the following changes to your arm-soc tree.
There are just two cleanup patches.

Thanks,
Michal


The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.11

for you to fetch changes up to 88cd4e882de73c2e62c38591abfe8c13fcc8386a:

  ARM: zynq: Not to rewrite jump code when starting address is 0x0 (2013-06-17 07:35:31 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq cleanup patches for v3.11

This branch contains two fixes:
- Fix zynq smp code
- Do not specify init_irq ptr

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: zynq: Remove init_irq declaration in machine description

Michal Simek (1):
      ARM: zynq: Not to rewrite jump code when starting address is 0x0

 arch/arm/mach-zynq/common.c  |  2 --
 arch/arm/mach-zynq/platsmp.c | 52 ++++++++++++++++++++++++++--------------------------
 2 files changed, 26 insertions(+), 28 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/3735ec98/attachment.sig>
