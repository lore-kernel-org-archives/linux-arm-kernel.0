From: monstr@monstr.eu (Michal Simek)
Date: Fri, 31 Jul 2015 10:55:34 +0200
Subject: [GIT PULL] Xilinx Zynq DT changes for v4.3
Message-ID: <55BB3806.7080806@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these zynq DT changes to your tree.

Thanks,
Michal

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-4.3

for you to fetch changes up to b76da4d8758995437a831748dfca6f64a0e31c95:

  ARM: zynq: DT: Add zc702 pushbuttons to DT as gpio-keys (2015-07-31
10:50:06 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v4.3

- Add ECC for Synopsys MC
- Add OCM, pushbuttons to zc702

----------------------------------------------------------------
Alex Wilson (1):
      ARM: zynq: DT: Add missing interrupt for L2 pl310

Ezra Savard (1):
      ARM: zynq: DT: Add zc702 pushbuttons to DT as gpio-keys

Michal Simek (1):
      ARM: dts: zynq: Add OCM node

Punnaiah Choudary Kalluri (1):
      Documentation: devicetree: Add ECC information to synopsys ddr
controller

 Documentation/devicetree/bindings/memory-controllers/synopsys.txt |  4 ++++
 arch/arm/boot/dts/zynq-7000.dtsi                                  |  3 ++-
 arch/arm/boot/dts/zynq-zc702.dts                                  | 28
++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/d7f08a2c/attachment.sig>
