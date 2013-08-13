From: monstr@monstr.eu (Michal Simek)
Date: Tue, 13 Aug 2013 16:50:43 +0200
Subject: arm-soc: Xilinx Zynq DT changes for v3.12
Message-ID: <520A47C3.5000106@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull this simple DT change to your tree.

Thanks,
Michal

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-for-3.12

for you to fetch changes up to 39c41df9c1950fba0ee6a4e7a63be281e89fe437:

  arm: zynq: dt: Set correct L2 ram latencies (2013-08-13 16:37:35 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt changes for v3.12

Fix L2 ram latencies.

----------------------------------------------------------------
Soren Brinkmann (1):
      arm: zynq: dt: Set correct L2 ram latencies

 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)



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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/6e10f60f/attachment-0001.sig>
