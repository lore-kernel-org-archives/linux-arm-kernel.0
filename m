From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 23:45:54 +0800
Subject: [GIT PULL] mxs/clk for v3.4
Message-ID: <20120131154552.GG26436@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following mxs clock changes for v3.4.  It has no
conflict with rmk/for-armsoc branch.

Regards,
Shawn

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/clk

Fabio Estevam (1):
      ARM: mxs: Use a proper timeout mechanism

Lothar Wa?mann (1):
      arm/mxs: Add support for SSP/MMC ports 2 & 3

Wolfram Sang (1):
      ARM: mx28: check for gated clocks when setting saif divider

 arch/arm/mach-mxs/clock-mx23.c               |   34 ++-------------
 arch/arm/mach-mxs/clock-mx28.c               |   57 ++++++-------------------
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c |    2 +
 arch/arm/mach-mxs/include/mach/common.h      |    2 +
 arch/arm/mach-mxs/system.c                   |   16 +++++++
 5 files changed, 39 insertions(+), 72 deletions(-)
