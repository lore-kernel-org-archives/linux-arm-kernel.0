From: monstr@monstr.eu (Michal Simek)
Date: Thu, 08 Jan 2015 09:49:51 +0100
Subject: [GIT PULL] Xilinx Zynq dt fixes for v3.19
In-Reply-To: <544519A4.5090003@monstr.eu>
References: <544519A4.5090003@monstr.eu>
Message-ID: <54AE44AF.6010808@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please consider to pull this one DT patch to your tree as fix for v3.19
It is adding USD dt node. Driver has been added to v3.19.

Thanks,
Michal

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-fixes-for-3.19

for you to fetch changes up to 1643b31658c44767a85469733c6bff4f6d0371c7:

  ARM: zynq: DT: Add USB to device tree (2015-01-08 09:35:04 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq DT fixes for v3.19

- Add USB chipidea driver to DT

----------------------------------------------------------------
Soren Brinkmann (1):
      ARM: zynq: DT: Add USB to device tree

 arch/arm/boot/dts/zynq-7000.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc702.dts | 11 +++++++++++
 arch/arm/boot/dts/zynq-zc706.dts | 10 ++++++++++
 arch/arm/boot/dts/zynq-zed.dts   | 10 ++++++++++
 4 files changed, 51 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/81bac99a/attachment.sig>
