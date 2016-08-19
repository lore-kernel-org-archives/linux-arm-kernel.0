From: monstr@monstr.eu (Michal Simek)
Date: Fri, 19 Aug 2016 12:40:12 +0200
Subject: [GIT PULL] ARM64: Xilinx ZynqMP DT changes for v4.9
Message-ID: <066cb4a0-d823-f940-5189-95302f098fd5@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these changes to your tree.

Thanks,
Michal

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.9

for you to fetch changes up to 908c9e733b1c8929f6e42094e58f9b2c06694247:

  ARM64: zynqmp: Correct the watchdog timer interrupt number (2016-08-19
12:31:36 +0200)

----------------------------------------------------------------
arm64: Xilinx ZynqMP dt patches for v4.9

- Fix gic ranges property
- Use 64bit size cells format
- Add PCIe node
- Correct pmu and watchdog nodes

----------------------------------------------------------------
Alexander Graf (1):
      ARM64: zynqmp: Align gic ranges for 64k in device tree

Michal Simek (3):
      ARM64: zynqmp: Use 64bit size cell format
      ARM64: zynqmp: Add PCIe node
      ARM64: zynqmp: Add missing interrupt-parent to PMU node

Punnaiah Choudary Kalluri (1):
      ARM64: zynqmp: Correct the watchdog timer interrupt number

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts |   2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 100
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 2 files changed, 71 insertions(+), 31 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160819/1326814e/attachment.sig>
