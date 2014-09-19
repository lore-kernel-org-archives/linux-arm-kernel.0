From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 19 Sep 2014 18:19:45 +0200
Subject: [GIT PULL] at91: soc 3.18 #1
Message-ID: <1411143585-31823-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A little SoC pull-request before the bigger one with SAMA5D4 support. This one
is just beginning the removal of board files in arch/arm/mach-at91 directory.

Thanks, best regards,

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-soc

for you to fetch changes up to 5db722eeba0051c68e638114f6720e715b03cd2c:

  ARM: at91: Remove the support for the RSI EWS board (2014-09-19 13:13:23 +0200)

----------------------------------------------------------------
First AT91 SoC batch for 3.18:
- removal of 2 board C files in mach-at91

----------------------------------------------------------------
Josef Holzmayr (1):
      ARM: at91: Remove the support for the RSI EWS board

Nicolas Ferre (1):
      ARM: at91: remove board file for Acme Systems Fox G20

 arch/arm/mach-at91/Kconfig.non_dt  |  12 --
 arch/arm/mach-at91/Makefile        |   2 -
 arch/arm/mach-at91/board-foxg20.c  | 272 -----------------------------------
 arch/arm/mach-at91/board-rsi-ews.c | 232 ------------------------------
 4 files changed, 518 deletions(-)
 delete mode 100644 arch/arm/mach-at91/board-foxg20.c
 delete mode 100644 arch/arm/mach-at91/board-rsi-ews.c

-- 
Nicolas Ferre
