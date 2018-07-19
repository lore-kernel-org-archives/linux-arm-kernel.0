From: monstr@monstr.eu (Michal Simek)
Date: Thu, 19 Jul 2018 09:52:41 +0200
Subject: [GIT PULL v2] arm64: zynqmp: Xilinx DT changes for v4.19
Message-ID: <c4c29579-8d05-a290-2d59-638170601849@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Based on discussion with Olof all patches are using these prefixes.
arm64: dts: zynqmp:

Please pull the following arm64 DT patches.

Thanks,
Michal

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-v4.19-v2

for you to fetch changes up to 41ee3e3883056f216bc1044c7ab1c8477b3384ad:

  arm64: dts: zynqmp: Add support for Avnet Ultra96 rev1 board
(2018-07-19 09:48:30 +0200)

----------------------------------------------------------------
arm: dts: zynqmp: DT changes for v4.19

- Use serdev for BT in zcu100
- Remove ep108
- Fix gpio-keys binding
- Add suport for Ultra96

----------------------------------------------------------------
Michal Simek (4):
      arm64: dts: zynqmp: Use serdev for zcu100 BT
      arm64: dts: zynqmp: Remove ep108 board
      arm64: dts: zynqmp: Remove #address/#size-cells from gpio-keys
      arm64: dts: zynqmp: Add support for Avnet Ultra96 rev1 board

 arch/arm64/boot/dts/xilinx/Makefile               |   2 +-
 arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts |  19 +++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi  | 137
-----------------------------------------------------------------------------------------------------------------------------------------
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts       | 154
----------------------------------------------------------------------------------------------------------------------------------------------------------
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts |  12 ++++--------
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts |   2 --
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts |   2 --
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts |   2 --
 8 files changed, 24 insertions(+), 306 deletions(-)
 create mode 100644 arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
 delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
 delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/c3e1c58c/attachment.sig>
