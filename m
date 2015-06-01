From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  1 Jun 2015 15:53:26 +0800
Subject: [GIT PULL 4/4] ARM: imx: defconfig updates for 4.2
In-Reply-To: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
References: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1433145206-2508-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.2

for you to fetch changes up to f218e14b62339c6c28aa0c419eba200463cec99a:

  ARM: imx_v6_v7_defconfig: updates for Armadeus Systems APF6 boards (2015-05-19 13:20:00 +0800)

----------------------------------------------------------------
The i.MX defconfig updates for 4.2:
 - Enable i.MX7D and LS1021A SoC support
 - Enable support for WL1271 WIFI/BT, SX8654 I2C touchscreen and PCF8523
   RTC, which can be found on Armadeus Systems APF6 and Cubox-i boards.

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Enable RTC PCF8523 support
      ARM: imx_v6_v7_defconfig: Select LS1021A

Frank Li (1):
      ARM: config: imx_v6_v7_defconfig add imx7d support

S??bastien Szymanski (1):
      ARM: imx_v6_v7_defconfig: updates for Armadeus Systems APF6 boards

 arch/arm/configs/imx_v6_v7_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)
