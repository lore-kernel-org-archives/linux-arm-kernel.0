From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 18 Jun 2013 10:33:21 +0200
Subject: [GIT PULL] at91: non critical fixes
Message-ID: <1371544401-22369-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Refurbish of preceding "soc" pull-request for extracting fixes. Note that this
at91-fixes tag is now based on v3.10-rc5 as I have found that it is the base of
your next/fixes-non-critical branch.

Thanks, best regards,

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 133e00116b5bc76110bcc41ded369489209b641f:

  ARM: at91: Change the internal SRAM memory type MT_MEMORY_NONCACHED (2013-06-18 10:20:30 +0200)

----------------------------------------------------------------
Two non critical fixes that can go in 3.11.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91: Fix link breakage when !CONFIG_PHYLIB

Wenyou Yang (1):
      ARM: at91: Change the internal SRAM memory type MT_MEMORY_NONCACHED

 arch/arm/mach-at91/Kconfig          | 1 +
 arch/arm/mach-at91/board-dt-sama5.c | 3 ++-
 arch/arm/mach-at91/setup.c          | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre
