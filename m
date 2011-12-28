From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 28 Dec 2011 22:21:35 +0800
Subject: [GIT PULL] imx: pm for 3.3
Message-ID: <20111228142134.GC10881@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following imx/pm changes for 3.3.

Regards,
Shawn

The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:

  Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/pm

Eric Miao (2):
      ARM: imx6q: build pm code only when CONFIG_PM selected
      ARM: imx6q: resume PL310 only when CACHE_L2X0 defined

Hui Wang (1):
      ARM: mx5: use generic irq chip pm interface for pm functions on

 arch/arm/mach-imx/Kconfig               |    1 +
 arch/arm/mach-imx/Makefile              |    6 ++++-
 arch/arm/mach-imx/head-v7.S             |   15 ++++++++---
 arch/arm/mach-imx/pm-imx6q.c            |    2 +
 arch/arm/mach-mx5/mm.c                  |   19 ++++++++++++++-
 arch/arm/mach-mx5/system.c              |    3 --
 arch/arm/plat-mxc/include/mach/common.h |    8 +++++-
 arch/arm/plat-mxc/include/mach/mxc.h    |    2 +-
 arch/arm/plat-mxc/tzic.c                |   40 ++++++++++++++++++++++--------
 9 files changed, 74 insertions(+), 22 deletions(-)
