From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Oct 2014 09:36:18 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.18
Message-ID: <20141026013617.GF6973@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.18

for you to fetch changes up to d1e61eb443dc7512885dfe89ee2f2a1c29fcb1da:

  ARM: dts: imx28-evk: Let i2c0 run at 100kHz (2014-10-25 20:17:36 +0800)

----------------------------------------------------------------
The i.MX fixes for 3.18:
 - Revert one patch which increases I2C bus frequency on imx28-evk
 - Fix a typo on imx6q EIM clock name

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx28-evk: Let i2c0 run at 100kHz

Steve Longerbeam (1):
      ARM: i.MX6: Fix "emi" clock name typo

 arch/arm/boot/dts/imx28-evk.dts           |  1 -
 arch/arm/mach-imx/clk-imx6q.c             | 14 +++++++-------
 include/dt-bindings/clock/imx6qdl-clock.h |  8 ++++----
 3 files changed, 11 insertions(+), 12 deletions(-)
