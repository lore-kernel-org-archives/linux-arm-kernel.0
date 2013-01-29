From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 23:42:19 -0700
Subject: [GIT PULL 1/4] ARM: bcm2835: cleanup
Message-ID: <1359441742-32647-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pull request simply converts the bcm2835 clocksource driver to use
the recently added CLKSRC_OF feature.

The branch is based on v3.8-rc3, followed by a merge of arm-soc's
timer/cleanup branch.

(For this and pull 4/4, feel free to cherry-pick the one commit if you
want to avoid the short pull requests!)

----------------------------------------------------------------

The following changes since commit b2fc382aad0a8f52803acdc3ac4e5540dbcdf1f6:

  Merge remote-tracking branch 'korg_arm-soc/timer/cleanup' into cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.9-cleanup

for you to fetch changes up to c1b724f6659a7e9e32f8fcf6409d053e1b7bccad:

  ARM: bcm2835: make use of CLKSRC_OF

----------------------------------------------------------------

Stephen Warren (1):
      ARM: bcm2835: make use of CLKSRC_OF

 arch/arm/Kconfig                    |    1 +
 arch/arm/mach-bcm2835/bcm2835.c     |    4 ++--
 drivers/clocksource/bcm2835_timer.c |    5 +++--
 include/linux/bcm2835_timer.h       |   22 ----------------------
 4 files changed, 6 insertions(+), 26 deletions(-)
 delete mode 100644 include/linux/bcm2835_timer.h
