From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 29 Apr 2016 01:47:00 +0300
Subject: NXP LPC32xx Mach Updates for v4.7
Message-ID: <572292E4.9010209@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

please consider to include NXP LPC32xx mach clean-up updates for v4.7.

I'm adding an official LPC32xx maintainer Roland to Cc, however
he seems to be unresponsive for a quite long time.

Thank you in advance.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://github.com/vzapolskiy/linux-lpc32xx.git tags/lpc32xx-soc-4.7

for you to fetch changes up to 71d42e9c71d7fca2eca98eac315cb485b5d2314d:

  ARM: lpc32xx: remove duplicate const on lpc32xx_auxdata_lookup (2016-04-28 00:45:12 +0300)

----------------------------------------------------------------
NXP LPC32xx mach updates for v4.7

This includes a few nonfunctional clean-ups for NXP LPC32xx:
* removed leftover from restart code migration to a watchdog driver
* removed dead code leftovers from migration to CCF driver
* fix double const qualifier

----------------------------------------------------------------
Sylvain Lemieux (1):
      ARM: lpc32xx: remove reboot header file

Vladimir Zapolskiy (2):
      ARM: lpc32xx: remove leftovers of legacy clock source and provider drivers
      ARM: lpc32xx: remove duplicate const on lpc32xx_auxdata_lookup

 arch/arm/mach-lpc32xx/common.c  | 95 -----------------------------------------
 arch/arm/mach-lpc32xx/common.h  | 24 +----------
 arch/arm/mach-lpc32xx/phy3250.c |  2 +-
 3 files changed, 2 insertions(+), 119 deletions(-)
