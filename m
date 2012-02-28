From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Feb 2012 10:28:24 +0800
Subject: [GIT PULL] imx driver for v3.4
Message-ID: <20120228022822.GE13886@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following imx driver changes for v3.4.

Regards,
Shawn

The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:

  Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/driver

Dirk Behme (1):
      ARM: imx6: Rename DEBUG_IMX6Q_UART to UART4

Richard Zhao (2):
      ARM: mxc: make imx_dma_is_general_purpose more generic for sdma
      ARM: imx6q: add cko1 clock

 arch/arm/Kconfig.debug                       |    6 +-
 arch/arm/mach-imx/clock-imx6q.c              |   74 +++++++++++++++++++++++++-
 arch/arm/mach-imx/lluart.c                   |    2 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S |    2 +-
 arch/arm/plat-mxc/include/mach/dma.h         |    3 +-
 5 files changed, 79 insertions(+), 8 deletions(-)
