From: monstr@monstr.eu (Michal Simek)
Date: Wed, 26 Sep 2018 09:24:17 +0200
Subject: [GIT PULL] ARM: dts: zynq: Xilinx DT changes for v4.20
Message-ID: <70e3d4cf-7f50-310e-57d4-b9598de84c7d@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull this one patch to your tree. It can supposed to be a fix but
the dtc changes, which expose these warnings, will be merged in v4.20.

Thanks,
Michal

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-v4.20

for you to fetch changes up to f5054ceed420b1f38d37920a4c65446fcc5d6b90:

  ARM: dts: xilinx: Fix I2C and SPI bus warnings (2018-09-18 12:49:39 +0200)

----------------------------------------------------------------
ARM: dts: zynq: DT changes for v4.20

- Fix DTS spi/i2c warnings for zc702/zc770 boards

----------------------------------------------------------------
Rob Herring (1):
      ARM: dts: xilinx: Fix I2C and SPI bus warnings

 arch/arm/boot/dts/zynq-zc702.dts       | 12 ++++++------
 arch/arm/boot/dts/zynq-zc770-xm010.dts |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180926/7ebd4070/attachment.sig>
