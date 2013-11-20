From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Nov 2013 20:21:37 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.13, part 2
Message-ID: <20131120122135.GA22308@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 036e29918078e38b0b127b89deb4c595028c1bc0:

  ARM: dts: i.MX51: Fix OTG PHY clock (2013-11-11 22:58:45 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.13-2

for you to fetch changes up to 793b4b10720174b6b27beaf915425248858d7fc5:

  ARM: dts: imx6qdl: disable spdif "rxtx5" clock option (2013-11-18 09:21:29 +0800)

----------------------------------------------------------------
The imx fixes for 3.13, part 2:
 - Disable S/PDIF "rxtx5" clock option to fix the clocksource breakage
   introduced by S/PDIF driver

----------------------------------------------------------------
Shawn Guo (1):
      ARM: dts: imx6qdl: disable spdif "rxtx5" clock option

 arch/arm/boot/dts/imx6qdl.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
