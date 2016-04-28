From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 28 Apr 2016 03:11:40 +0300
Subject: NXP LPC32xx Defconfig Updates for v4.7
Message-ID: <5721553C.8050701@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

please consider to include NXP LPC32xx defconfig updates for v4.7.

I'm adding an official LPC32xx maintainer Roland to Cc, however
he seems to be unresponsive for a quite long time.

Thank you in advance.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://github.com/vzapolskiy/linux-lpc32xx.git tags/lpc32xx-defconfig-4.7

for you to fetch changes up to 3b3c6ad5353951cd01523add5a1930c743d4f807:

  ARM: LPC32xx: add PL175 memory controller driver to defconfig (2016-04-21 22:25:26 +0300)

----------------------------------------------------------------
NXP LPC32xx defconfig updates for v4.7

This includes savedefconfig update of lpc32xx_defconfig, which removes
a number of outdated config options, plus ARM PrimeCell PL17x memory
controller driver is enabled by default now, on LPC32xx boards the
controller is commonly used to access SDRAM and NOR.

----------------------------------------------------------------
Vladimir Zapolskiy (2):
      ARM: LPC32xx: defconfig update
      ARM: LPC32xx: add PL175 memory controller driver to defconfig

 arch/arm/configs/lpc32xx_defconfig | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)
