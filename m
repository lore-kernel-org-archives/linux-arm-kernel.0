From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 2 Mar 2012 09:01:05 +0100
Subject: [GIT PULL] i.MX3 patches
Message-ID: <20120302080105.GJ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following i.MX3 specific patches for -next. Note
that 1/2 depends on your imx/cleanup branch since it includes
crmregs-imx3.h which is created in this branch.

Sascha

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git features/imx3

for you to fetch changes up to bb07d7511e0884f913a0610d5f9a2f8a27914042:

  ARM: mx3: Setup AIPS registers (2012-03-02 08:49:37 +0100)

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: mx3: Let mx31 and mx35 enter in LPM mode in WFI
      ARM: mx3: Setup AIPS registers

 arch/arm/mach-imx/Makefile              |    4 +-
 arch/arm/mach-imx/crmregs-imx31.h       |    1 +
 arch/arm/mach-imx/mm-imx3.c             |    5 ++++
 arch/arm/mach-imx/pm-imx3.c             |   37 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/cpu.c                 |   24 ++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    9 +++++++
 6 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-imx/pm-imx3.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
