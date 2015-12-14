From: monstr@monstr.eu (Michal Simek)
Date: Mon, 14 Dec 2015 13:19:24 +0100
Subject: [GIT PULL] ARM64: Xilinx ZynqMP DT changes for v4.5
Message-ID: <566EB3CC.6070701@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull this one patch to your tree. Move patches will come for 4.6.

Thanks,
Michal

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.5

for you to fetch changes up to bdd5739008617c594ac231b1427d23f2c9000fcd:

  ARM64: zynqmp: DT: Add interrupt-controller property to GPIO
(2015-12-14 09:48:20 +0100)

----------------------------------------------------------------
arm: Xilinx ZynqMP dt patches for v4.5

- Label GPIO controller as interrupt controller

----------------------------------------------------------------
Soren Brinkmann (1):
      ARM64: zynqmp: DT: Add interrupt-controller property to GPIO

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

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
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/e9b95f9b/attachment.sig>
