From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 8 Feb 2013 12:36:15 +0100
Subject: [GIT PULL] at91: little cleanup for 3.9
Message-ID: <5114E32F.8030209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

There is a cleanup pull-request that allows us to remove
an unused AT91 board file.

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-cleanup

for you to fetch changes up to 80916a1a55eb71e511be904b2497b640b5fa02b3:

  ARM: at91: remove NEOCORE 926 board (2013-02-07 18:46:55 +0100)

----------------------------------------------------------------
Little AT91 cleanup: only remove one deprecated board.

----------------------------------------------------------------
Nicolas Ferre (1):
      ARM: at91: remove NEOCORE 926 board

 arch/arm/mach-at91/Kconfig            |   6 -
 arch/arm/mach-at91/Makefile           |   1 -
 arch/arm/mach-at91/board-neocore926.c | 387 -----------------------------------
 3 files changed, 394 deletions(-)
 delete mode 100644 arch/arm/mach-at91/board-neocore926.c

Best regards,
-- 
Nicolas Ferre
