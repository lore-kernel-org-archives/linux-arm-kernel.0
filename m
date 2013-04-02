From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 21:46:29 +0800
Subject: [GIT PULL] imx fixes for 3.9, take 5
Message-ID: <20130402134627.GF24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.9-5

for you to fetch changes up to 710b213d3f1cdb0451fa2d5a71faa2b1f510e3ad:

  ARM: imx35 Bugfix admux clock (2013-04-02 21:05:40 +0800)

----------------------------------------------------------------
The imx fixes for 3.9, take 5:
 - One fix for the typo in use of Kconfig symbol
   MACH_EUKREA_CPUIMX27_USEUART4.  It's been there for a long time
   and got caught by code inspection recently.  It hasn't been noticed
   earlier probably because it does not cause any problem in real.
 - A couple of fixes on imx35 clock driver to have audmux functional
   and iomux pad configurable after a reboot.

----------------------------------------------------------------
Markus Pargmann (2):
      ARM: clk-imx35: Bugfix iomux clock
      ARM: imx35 Bugfix admux clock

Paul Bolle (1):
      cpuimx27 and mbimx27: prepend CONFIG_ to Kconfig macro

 arch/arm/mach-imx/clk-imx35.c                |    2 ++
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    4 ++--
 arch/arm/mach-imx/mach-cpuimx27.c            |    4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)
