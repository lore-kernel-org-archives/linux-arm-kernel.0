From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 7 Jun 2012 22:46:24 +0800
Subject: [GIT PULL] imx fixes for v3.5-rc
Message-ID: <20120607144622.GB3750@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following fixes for v3.5-rc.  Thanks.

Regards,
Shawn

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/fixes-for-3.5

Fabio Estevam (2):
      ARM: mx31: Add pinctrl_provide_dummies()
      ARM: mx51: Add pinctrl_provide_dummies()

Shawn Guo (1):
      ARM: imx6: exit coherency when shutting down a cpu

 arch/arm/mach-imx/hotplug.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-imx/mm-imx3.c |    2 ++
 arch/arm/mach-imx/mm-imx5.c |    2 ++
 3 files changed, 45 insertions(+), 1 deletions(-)
