From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Apr 2013 20:56:22 +0800
Subject: [GIT PULL] mxs fixes for 3.9, take 4
Message-ID: <20130403125620.GA21790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-fixes-3.9-4

for you to fetch changes up to 55985e15b80beb339d3e332f00a26003deff14e6:

  ARM: mxs: Slow down the I2C clock speed (2013-04-03 09:34:01 +0800)

----------------------------------------------------------------
The mxs fixes for 3.9, take 4:
 - A couple mxs boards that run I2C at 400 kHz experience some unstable
   issue occasionally.  Slow down the clock speed to have I2C work
   reliably.

----------------------------------------------------------------
Marek Vasut (1):
      ARM: mxs: Slow down the I2C clock speed

 arch/arm/boot/dts/imx28-m28evk.dts |    1 -
 arch/arm/boot/dts/imx28-sps1.dts   |    1 -
 2 files changed, 2 deletions(-)
