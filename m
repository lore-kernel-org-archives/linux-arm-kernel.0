From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 08 Nov 2016 11:02:05 -0500
Subject: [GIT PULL] NXP LPC32xx ARM SoC cleanup for v4.10
Message-ID: <1478620925.12841.25.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

please consider to include NXP LPC32xx cleanup for v4.10.

Thank you in advance.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/sylemieux/linux-lpc32xx.git tags/lpc32xx-cleanup-v4.10

for you to fetch changes up to d1193df9c3cbce699d07c352bb3c055cd827db4d:

  ARM: lpc32xx: remove unused header file clock.h (2016-10-25 13:33:01 -0400)

----------------------------------------------------------------
NXP LPC32xx ARM SoC cleanup for v4.10

This includes a few cleanup changes:
* remove unused header file mach/irqs.h;
* remove unused header file clock.h.

----------------------------------------------------------------
Vladimir Zapolskiy (2):
      ARM: lpc32xx: remove unused header file mach/irqs.h
      ARM: lpc32xx: remove unused header file clock.h

 arch/arm/mach-lpc32xx/clock.h             |  38 ----------
 arch/arm/mach-lpc32xx/common.h            |   1 -
 arch/arm/mach-lpc32xx/include/mach/irqs.h | 117 ------------------------------
 arch/arm/mach-lpc32xx/pm.c                |   1 -
 4 files changed, 157 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/clock.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/irqs.h
