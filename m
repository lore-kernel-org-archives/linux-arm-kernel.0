From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Mar 2013 14:00:59 +0800
Subject: [GIT PULL] imx fixes for 3.9, take 3
Message-ID: <20130319060055.GK12462@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.9-3

for you to fetch changes up to 287939a3690c8da6fd3310d7593ff0448cb9447c:

  ARM: imx: add dependency check for DEBUG_IMX_UART_PORT (2013-03-19 13:56:05 +0800)

----------------------------------------------------------------
The imx fixes for 3.9, take 3:
 - Add the lost dependency check for DEBUG_IMX_UART_PORT back

----------------------------------------------------------------
Shawn Guo (1):
      ARM: imx: add dependency check for DEBUG_IMX_UART_PORT

 arch/arm/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)
