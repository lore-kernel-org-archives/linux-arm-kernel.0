From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 5 Jan 2012 14:19:06 +0800
Subject: [GIT PULL] imx: pm changes for 3.3, part 2
Message-ID: <20120105061905.GE14741@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following two patches for 3.3.

Regards,
Shawn

The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:

  Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/pm2

Shawn Guo (2):
      ARM: imx6: fix v7_invalidate_l1 by adding I-Cache invalidation
      ARM: imx6: remove __CPUINIT annotation from v7_invalidate_l1

 arch/arm/mach-imx/head-v7.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
