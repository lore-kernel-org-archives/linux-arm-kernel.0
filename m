From: monstr@monstr.eu (Michal Simek)
Date: Wed, 19 Aug 2015 13:11:43 +0200
Subject: [GIT PULL] Xilinx Zynq DT changes for v4.3 v2
Message-ID: <55D4646F.7010404@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Philipp just sent his PR to you with adding reset controller for Zynq
(http://www.spinics.net/lists/arm-kernel/msg440136.html).
Can you please consider to add this one more patch to your tree?
It is one more patch on the top of existing zynq/dt branch which you
already have in arm-soc git repo.

Thanks,
Michal

The following changes since commit b76da4d8758995437a831748dfca6f64a0e31c95:

  ARM: zynq: DT: Add zc702 pushbuttons to DT as gpio-keys (2015-07-31
10:50:06 +0200)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-4.3-v2

for you to fetch changes up to d8ae96c948ccb6c4274f007eb2ffd27ed656783a:

  dts: zynq: Add devicetree entry for Xilinx Zynq reset controller.
(2015-08-19 13:03:23 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v4.3 v2

- Enable reset driver for Zynq

----------------------------------------------------------------
Moritz Fischer (1):
      dts: zynq: Add devicetree entry for Xilinx Zynq reset controller.

 arch/arm/boot/dts/zynq-7000.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/e76aabb6/attachment.sig>
