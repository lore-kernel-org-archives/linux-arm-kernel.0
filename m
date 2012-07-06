From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 13:45:02 +0800
Subject: [GIT PULL] imx6 cleanup for 3.6
Message-ID: <20120706054501.GE20503@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following imx6 cleanup for 3.6.

Regards,
Shawn

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/cleanup-for-3.6

Shawn Guo (1):
      ARM: imx6q: remove unneeded clkdev lookups

 arch/arm/mach-imx/clk-imx6q.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)
