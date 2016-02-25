From: monstr@monstr.eu (Michal Simek)
Date: Thu, 25 Feb 2016 14:23:20 +0100
Subject: [GIT PULL] ARM32: Xilinx Zynq DT changes for v4.6
Message-ID: <56CF0048.7060601@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these two patches to your tree.

Thanks,
Michal

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-4.6

for you to fetch changes up to 07bf429da13dfa3f0b40dce4ef2a1437544a6096:

  ARM: zynq: Use earlycon instead of earlyprintk (2016-02-25 14:01:34 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v4.5

- Add usb phy for Zybo
- Use earlycon instead of earlyprintk

----------------------------------------------------------------
Michal Simek (1):
      ARM: zynq: Use earlycon instead of earlyprintk

Nathan Rossi (1):
      ARM: dts: zynq: Enable USB and USB PHY for ZYBO

 arch/arm/boot/dts/zynq-parallella.dts |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts      |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts      |  2 +-
 arch/arm/boot/dts/zynq-zed.dts        |  2 +-
 arch/arm/boot/dts/zynq-zybo.dts       | 13 ++++++++++++-
 5 files changed, 16 insertions(+), 5 deletions(-)


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/db667228/attachment.sig>
