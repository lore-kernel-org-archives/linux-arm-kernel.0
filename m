From: monstr@monstr.eu (Michal Simek)
Date: Thu, 30 Jan 2014 17:10:30 +0100
Subject: [GIT PULL] Xilinx Zynq dt fixes for v3.14
Message-ID: <52EA7976.7030709@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

please consider to queue this patch to 3.14 because it enables Arasan
SDHCI driver which has been merged to the tree. It took for a while
to get it to the mainline that's why I didn't push this patch
in regular arm-soc merge window. I was talking about it
with Kevin some weeks ago.

There will be one more patch which I have discussed with Russell but
I will send it out for reviewed first.
https://lkml.org/lkml/2014/1/27/212

Thanks,
Michal


The following changes since commit 9b0cd304f26b9fca140de15deeac2bf357d1f388:

  Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux (2014-01-29 20:49:12 -0800)

are available in the git repository at:


  git://git.xilinx.com/linux-xlnx.git tags/zynq-dt-fixes-for-3.14

for you to fetch changes up to b1d30fb5b8618e69195fb074b89c204cb1bb2262:

  arm: dt: zynq: Add SDHCI nodes (2014-01-30 12:28:03 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq DT fixes for v3.14

- Enable Arasan SDHCI driver

----------------------------------------------------------------
Soren Brinkmann (1):
      arm: dt: zynq: Add SDHCI nodes

 arch/arm/boot/dts/zynq-7000.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc702.dts |  4 ++++
 arch/arm/boot/dts/zynq-zc706.dts |  4 ++++
 arch/arm/boot/dts/zynq-zed.dts   |  4 ++++
 4 files changed, 32 insertions(+)


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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140130/e3b3b418/attachment.sig>
