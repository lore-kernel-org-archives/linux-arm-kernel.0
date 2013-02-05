From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 16:15:23 +0800
Subject: [GIT PULL] imx fixes for 3.8, take 4
Message-ID: <20130205081521.GA5537@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e6b267ce14f61d9da0151b97ee26ab4d38055567:

  video: imxfb: Do not crash on reboot (2013-01-17 16:14:29 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.8-4

for you to fetch changes up to 8dd5c66bc6b12d86b1656851c20946efd587875e:

  ARM: dts: imx6: fix fec ptp clock slow 10 time (2013-02-05 15:11:23 +0800)

----------------------------------------------------------------
imx fixes for 3.8, take 4

 - It fixes fec ptp clock pointer in device tree source.

----------------------------------------------------------------
Frank Li (1):
      ARM: dts: imx6: fix fec ptp clock slow 10 time

 arch/arm/boot/dts/imx6q.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
