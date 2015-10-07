From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 7 Oct 2015 18:27:29 +0530
Subject: [GIT PULL] DaVinci non-critical fixes for v4.4
Message-ID: <561516B9.1060307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.4/fixes

for you to fetch changes up to f6c1a8a6ce19d30c235ef0fa285d5110aafaefe2:

  ARM: davinci: clock: Correct return values for API functions (2015-10-07 16:41:29 +0530)

----------------------------------------------------------------
Fix for incorrect handling of NULL clk pointer in
DaVinci clock code. And a fix to use a more appropiate
format specifier in a debug message.

----------------------------------------------------------------
Andy Shevchenko (1):
      ARM: davinci: re-use %*ph specifier

Peter Ujfalusi (1):
      ARM: davinci: clock: Correct return values for API functions

 arch/arm/mach-davinci/board-dm644x-evm.c |  4 +---
 arch/arm/mach-davinci/clock.c            | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)
