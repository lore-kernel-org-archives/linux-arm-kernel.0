From: monstr@monstr.eu (Michal Simek)
Date: Wed, 18 Jul 2018 16:14:48 +0200
Subject: [GIT PULL] arm64: zynqmp: Xilinx DT changes for v4.19
Message-ID: <a0dc4c86-7fe6-b9f6-2d57-b418061dbb3c@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull the following arm64 DT patches.

Thanks,
Michal

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-v4.19

for you to fetch changes up to d287de28641beb953f7ab2bd6966b166ea5c6e99:

  arm64: zynqmp: Add support for Avnet Ultra96 rev1 board (2018-07-17
16:41:09 +0200)

----------------------------------------------------------------
arm: zynqmp: DT changes for v4.19

- Use serdev for BT in zcu100
- Remove ep108
- Fix gpio-keys binding
- Add suport for Ultra96

----------------------------------------------------------------
Michal Simek (4):
      arm64: zynqmp: Use serdev for zcu100 BT
      arm64: zynqmp: Remove ep108 board
      arm64: zynqmp: Remove #address/#size-cells from gpio-keys
      arm64: zynqmp: Add support for Avnet Ultra96 rev1 board

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180718/a692fc3a/attachment-0001.sig>
