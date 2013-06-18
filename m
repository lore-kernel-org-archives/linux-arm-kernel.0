From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 18 Jun 2013 10:43:40 +0200
Subject: [GIT PULL] at91: cleanup for 3.11 #2
Message-ID: <1371545020-23186-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

The patch that was remaining from my old "soc" pull-request. It is stacked on
top of the "cleanup" patches already send as recommended by Olof.

Thanks, best regards,

The following changes since commit b3f442b0eedbc20b5ce3f4a96530588d14901199:

  ARM: at91: udpate defconfigs (2013-05-17 15:05:08 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-cleanup

for you to fetch changes up to e25ac142f3c8476410a562c481e5c29efbb1cd43:

  ARM: at91: drop rm9200dk board support (2013-06-18 10:23:15 +0200)

----------------------------------------------------------------
One old board removal.

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: drop rm9200dk board support

 arch/arm/configs/at91rm9200_defconfig |   1 -
 arch/arm/mach-at91/Kconfig.non_dt     |   7 --
 arch/arm/mach-at91/Makefile           |   1 -
 arch/arm/mach-at91/board-rm9200dk.c   | 228 ----------------------------------
 4 files changed, 237 deletions(-)
 delete mode 100644 arch/arm/mach-at91/board-rm9200dk.c

-- 
Nicolas Ferre
