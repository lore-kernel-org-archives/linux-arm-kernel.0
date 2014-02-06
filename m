From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Feb 2014 22:51:02 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.14
Message-ID: <20140206145058.GA6610@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The 3.13 stable tree will also need this fix.  But since it does not
apply to 3.13 cleanly, we will need to send another one for 3.13
stable kernel, after this one hits mainline.

Shawn

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.14

for you to fetch changes up to 5d0a87ba5875794ec3df14aa74ee8e18ef47d6b4:

  ARM: imx6: Initialize low-power mode early again (2014-02-06 20:26:26 +0800)

----------------------------------------------------------------
i.MX fixes for 3.14:
 - Fix a regression (system hang) when preemption is enabled
   (CONFIG_PREEMPT=y).

----------------------------------------------------------------
Philipp Zabel (1):
      ARM: imx6: Initialize low-power mode early again

 arch/arm/mach-imx/clk-imx6q.c  |    3 +++
 arch/arm/mach-imx/clk-imx6sl.c |    3 +++
 arch/arm/mach-imx/pm-imx6q.c   |    2 --
 3 files changed, 6 insertions(+), 2 deletions(-)
