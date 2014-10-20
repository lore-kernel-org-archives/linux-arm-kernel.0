From: monstr@monstr.eu (Michal Simek)
Date: Mon, 20 Oct 2014 16:18:12 +0200
Subject: [GIT PULL] Xilinx Zynq dt fixes for v3.18
Message-ID: <544519A4.5090003@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

please pull these dt fixes to your tree.

The last one is really trivial that's why I have also added it.
Two patches fixing problems with two GEMs and OPP.
Missing references are needed for our device-tree generator
which requires to have references that's why I have considered
this as bug fixes.

Please let me know if you have any problem with them.

Thanks,
Michal


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-fixes-for-3.18

for you to fetch changes up to 2329efbbca2943f03fa1c7306ef2f6a053be0ae5:

  ARM: zynq: DT: trivial: Fix mc node (2014-10-20 15:20:17 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq DT fixes for v3.18

- Fix gem register size
- Fix OPP
- Add missing references
- Trivial cleanup

----------------------------------------------------------------
Michal Simek (5):
      ARM: zynq: DT: Add missing address for L2 pl310
      ARM: zynq: DT: Add missing reference for ADC
      ARM: zynq: DT: Add missing reference for memory-controller
      ARM: zynq: DT: Add cadence watchdog node
      ARM: zynq: DT: trivial: Fix mc node

Soren Brinkmann (2):
      ARM: zynq: DT: Fix GEM register area size
      ARM: zynq: DT: Remove 222 MHz OPP

 arch/arm/boot/dts/zynq-7000.dtsi | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141020/53a7514a/attachment.sig>
