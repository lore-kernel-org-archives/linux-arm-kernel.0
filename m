From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Jan 2015 16:02:45 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.19, 2nd round
Message-ID: <20150123080244.GA27337@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7a9f0604bd56936b2b18f49824e0e392dc7878c3:

  ARM: dts: imx51-babbage: Fix ULPI PHY reset modelling (2015-01-06 20:25:58 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.19-2

for you to fetch changes up to 7ecd0bde5bfea524a843ad8fa8cb66ccbce68779:

  ARM: dts: imx25: Fix PWM "per" clocks (2015-01-20 15:37:10 +0800)

----------------------------------------------------------------
The i.MX fixes for 3.19, 2nd round:
 - Correct pwm clock assignment in i.MX25 device tree to fix the broken
   pwm support on i.MX25

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx25: Fix PWM "per" clocks

 arch/arm/boot/dts/imx25.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
