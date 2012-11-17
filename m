From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 21:02:35 -0700
Subject: [GIT PULL 1/3] ARM: bcm2835: cleanup
Message-ID: <1353124957-23808-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a few minor/trivial cleanups.

----------------------------------------------------------------

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git bcm2835-for-3.8-cleanup

for you to fetch changes up to 0bd1e3240ee49cba6fe243a317e07c8cc8e27334:

  ARM: bcm2835: remove useless variables from Makefile.boot

----------------------------------------------------------------

Domenico Andreoli (2):
      ARM: bcm2835: Add missing static modifiers
      ARM: bcm2835: Fix typo in the error message

Thomas Petazzoni (1):
      ARM: bcm2835: remove useless variables from Makefile.boot

 arch/arm/mach-bcm2835/Makefile.boot |    4 +---
 arch/arm/mach-bcm2835/bcm2835.c     |    4 ++--
 drivers/clk/clk-bcm2835.c           |    2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)
