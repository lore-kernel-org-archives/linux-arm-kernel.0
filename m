From: monstr@monstr.eu (Michal Simek)
Date: Tue, 16 Sep 2014 13:07:53 +0200
Subject: [GIT PULL] Xilinx Zynq dt changes for v3.18
Message-ID: <54181A09.7030902@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

please pull these patches to your tree.

Thanks,
Michal

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-for-3.18

for you to fetch changes up to 6f752f70a3a344af53d0e8100c2f7c15074b0651:

  ARM: zynq: Add ISL9305 regulator on Parallella board (2014-09-16 12:48:57 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.18

- Add eth phys
- Add led for zc702
- Various dts cleanups

----------------------------------------------------------------
Ezra Savard (1):
      ARM: zynq: DT: Add LEDs to zc702 DT

Mark Brown (1):
      ARM: zynq: Add ISL9305 regulator on Parallella board

Michal Simek (5):
      ARM: zynq: DT: Update years in header
      ARM: zynq: DT: Use 0x prefix for memory nodes
      ARM: zynq: DT: Extend compatible string for zedboard
      ARM: zynq: DT: Describe interrupt-names for pl330
      ARM: zynq: DT: Fix coding style issues in dtsi

Soren Brinkmann (3):
      ARM: zynq: DT: Fix Ethernet phy modes
      ARM: zynq: DT: Move size/address properties to dtsi
      ARM: zynq: DT: Add Ethernet phys

 arch/arm/boot/dts/zynq-7000.dtsi      | 14 ++++++++++----
 arch/arm/boot/dts/zynq-parallella.dts | 27 ++++++++++++++++++++++++---
 arch/arm/boot/dts/zynq-zc702.dts      | 18 ++++++++++++++++--
 arch/arm/boot/dts/zynq-zc706.dts      | 12 ++++++++----
 arch/arm/boot/dts/zynq-zed.dts        | 14 +++++++++-----
 5 files changed, 67 insertions(+), 18 deletions(-)



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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140916/06c6748d/attachment.sig>
