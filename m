From: monstr@monstr.eu (Michal Simek)
Date: Mon, 16 Oct 2017 15:08:01 +0200
Subject: [GIT PULL] ARM: Xilinx Zynq DT patches for v4.15
Message-ID: <de3bd1fb-85b4-81de-d546-7f9fc92ecf16@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please apply the following patch.

Thanks,
Michal

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-4.15

for you to fetch changes up to 3a42d36c6a2be960d9c7fe1ec7676aa04db572d4:

  ARM: dts: zynq: Add generic compatible string for I2C EEPROM
(2017-09-20 15:10:40 +0200)

----------------------------------------------------------------
arm: Xilinx ZynqMP DT changes for v4.15

- Change 24c08 compatible string

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: zynq: Add generic compatible string for I2C EEPROM

 arch/arm/boot/dts/zynq-zc702.dts | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171016/9f18bb1f/attachment-0001.sig>
