From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 18:17:21 +0200
Subject: [GIT PULL] ux500 fixes for v3.10-rc1+
Message-ID: <CACRpkdY2Pd9o+PMmabKs5Zj56GRsGtva8eQENgu8w-VjZy2hHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

please pull the following ux500 fixes for the v3.10-rc series.
Brief info in the signed tag.

Yours,
Linus Walleij

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-arm-soc-v3.10-fixes

for you to fetch changes up to 74ba4ec7a2036f9dbe5fcc85c7c737222005507f:

  ARM: ux500: select REGULATOR (2013-05-15 15:54:00 +0200)

----------------------------------------------------------------
Some ux500 fixes for the v3.10-rc series:
- Fixes up the debug UART
- Fix dangerous platform data double-assignment
- Fix auxdata for the ethernet device
- Select REGULATOR to satisfy Kconfig

----------------------------------------------------------------
Emilio L??pez (1):
      ARM: ux500: select REGULATOR

Lee Jones (3):
      ARM: ux500: Remove duplicated assignment of ab8500_platdata
      ARM: ux500: Fix incorrect DEBUG UART virtual addresses
      ARM: ux500: Provide device enumeration number suffix for SMSC911x

 arch/arm/include/debug/ux500.S     | 6 +++---
 arch/arm/mach-ux500/Kconfig        | 1 +
 arch/arm/mach-ux500/board-mop500.c | 6 +++---
 arch/arm/mach-ux500/cpu-db8500.c   | 6 ++----
 arch/arm/mach-ux500/setup.h        | 2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)
