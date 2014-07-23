From: monstr@monstr.eu (Michal Simek)
Date: Wed, 23 Jul 2014 14:26:40 +0200
Subject: [GIT PULL] Xilinx Zynq dt changes for v3.17 - second pull request
Message-ID: <53CFAA00.3080008@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please add these two patches to your arm-soc tree.
This branch is based on zynq/dt branch which is already
in your tree.
http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/log/?h=zynq/dt

GPIO driver and binding are already available in Linus gpio tree
and it enables us to do testing on Linux-next.

Thanks,
Michal


The following changes since commit 8fe9346b945d76ddb3f08c00e34d701174c62fa0:

  ARM: zynq: DT: Migrate UART to Cadence binding (2014-07-18 11:54:24 +0200)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-for-3.17-2

for you to fetch changes up to e0a5c552caf7a4865f3d5aa077003ef2d35217db:

  ARM: zynq: DT: Add GPIO node (2014-07-23 14:05:56 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.17 second pull request

- Add GPIO and XADC node to dtsi

----------------------------------------------------------------
Soren Brinkmann (2):
      ARM: zynq: DT: Add XADC node
      ARM: zynq: DT: Add GPIO node

 arch/arm/boot/dts/zynq-7000.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140723/2c790792/attachment.sig>
