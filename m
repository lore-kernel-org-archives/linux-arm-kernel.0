From: monstr@monstr.eu (Michal Simek)
Date: Fri, 31 Jul 2015 10:29:28 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v4.3
Message-ID: <55BB31E8.7040806@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these SoC changes to your tree.

Thanks,
Michal

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.3

for you to fetch changes up to e4a9288942392965bd5cfad93d9996b83c0dc4a6:

  ARM: zynq: reserve space for jump target in secondary trampoline
(2015-07-31 10:24:41 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq SoC patches for v4.2

- Fix earlyprintk, jump trampoline for SMP
- Update git tree location
- Setup PL310 aux (bit 22)

----------------------------------------------------------------
Arun Chandran (1):
      ARM: zynq: Fix earlyprintk in big endian mode

Masahiro Yamada (1):
      clk: zynq: remove redundant $(CONFIG_ARCH_ZYNQ) in Makefile

Nathan Lynch (1):
      ARM: zynq: reserve space for jump target in secondary trampoline

Soren Brinkmann (1):
      MAINTAINERS: Update Zynq git tree location

Thomas Betker (1):
      ARM: zynq: Set bit 22 in PL310 AuxCtrl register (6395/1)

 MAINTAINERS                   | 2 +-
 arch/arm/include/debug/zynq.S | 2 +-
 arch/arm/mach-zynq/common.c   | 4 ++--
 arch/arm/mach-zynq/headsmp.S  | 2 +-
 drivers/clk/zynq/Makefile     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/85e4fd8e/attachment.sig>
