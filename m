From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 6 Dec 2011 10:10:05 +0800
Subject: [GIT PULL] imx: fix add_irq_domain
Message-ID: <20111206021004.GH2980@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the add_irq_domain fixing below for -rc, and then I can
base my gpio interrupt cleanup series on top of it.  Thanks.

Regards,
Shawn

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/fix-irqdomain

Shawn Guo (2):
      arm/imx: fix return type of callback passed to of_irq_init()
      arm/imx: fix irq_base for gpio

 arch/arm/mach-imx/mach-imx6q.c |    9 +++++----
 arch/arm/mach-mx5/imx51-dt.c   |   12 +++++++-----
 arch/arm/mach-mx5/imx53-dt.c   |   12 +++++++-----
 3 files changed, 19 insertions(+), 14 deletions(-)
