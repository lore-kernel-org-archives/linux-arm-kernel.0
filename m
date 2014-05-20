From: monstr@monstr.eu (Michal Simek)
Date: Tue, 20 May 2014 16:23:37 +0200
Subject: [GIT PULL] Xilinx Zynq dt changes for v3.16
Message-ID: <537B6569.2010005@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

please pull these 3 patches to your tree.

Thanks,
Michal


The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-for-3.16

for you to fetch changes up to e1e22df1380d689209ddfab061847cc541941667:

  ARM: zynq: dt: Add a fixed regulator for CPU voltage (2014-05-16 14:54:14 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.16

- Cleanup GIC mode
- Cleanup node names
- Add regulators

----------------------------------------------------------------
Lucas Stach (1):
      ARM: dts: zynq: drop address cells from GIC node

Soren Brinkmann (2):
      ARM: zynq: dt: Clean up device tree
      ARM: zynq: dt: Add a fixed regulator for CPU voltage

 arch/arm/boot/dts/zynq-7000.dtsi | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/9e73ed53/attachment.sig>
