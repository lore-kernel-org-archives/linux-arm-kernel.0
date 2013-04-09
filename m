From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 9 Apr 2013 10:20:07 +0200
Subject: [GIT PULL] at91: little cleanup for 3.10 #3
Message-ID: <1365495607-30320-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Again more trivial cleanup for AT91. It is based on material already sent and
present in arm-soc/at91/cleanup2.

Thanks, best regards,

The following changes since commit e7619459d47a673af3433208a42f583af920e9db:

  ARM: at91: Fix typo in restart code panic message (2013-03-26 12:21:25 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-cleanup

for you to fetch changes up to 3aa630b3e6be83c4e91a68537fe6edf80f8d295e:

  ARM: at91: remove trailing semicolon from macros (2013-04-08 17:47:44 +0200)

----------------------------------------------------------------
Trivial typos and some macros removal & modification

----------------------------------------------------------------
Johan Hovold (2):
      ARM: at91/setup: fix trivial typos
      ARM: at91: remove trailing semicolon from macros

Nicolas Ferre (1):
      ARM: at91: remove unused dbgu_readl() macro

 arch/arm/mach-at91/at91_rstc.h                | 2 +-
 arch/arm/mach-at91/at91_shdwc.h               | 2 +-
 arch/arm/mach-at91/at91x40_time.c             | 2 +-
 arch/arm/mach-at91/include/mach/at91_dbgu.h   | 3 ---
 arch/arm/mach-at91/include/mach/at91_matrix.h | 2 +-
 arch/arm/mach-at91/include/mach/at91_st.h     | 2 +-
 arch/arm/mach-at91/setup.c                    | 6 +++---
 7 files changed, 8 insertions(+), 11 deletions(-)

-- 
Nicolas Ferre
