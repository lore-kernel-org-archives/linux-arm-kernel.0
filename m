From: khilman@ti.com (Kevin Hilman)
Date: Fri, 20 May 2011 17:25:24 +0200
Subject: [GIT PULL] OMAP PM cleanups for 2.6.40
Message-ID: <87liy15r8b.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following OMAP PM related cleanups for 2.6.40.

Thanks,

Kevin


The following changes since commit 61c4f2c81c61f73549928dfd9f3e8f26aa36a8cf:

  Linux 2.6.39 (2011-05-18 21:06:34 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.40/pm-cleanup

Jean Pihet (5):
      OMAP3 cpuidle: remove useless SDP specific timings
      OMAP3: clean-up mach specific cpuidle data structures
      OMAP3: cpuidle: re-organize the C-states data
      OMAP3: cpuidle: code rework for improved readability
      OMAP3: cpuidle: change the power domains modes determination logic

Sanjeev Premi (1):
      OMAP3: PM: Boot message is not an error, and not helpful, remove it

 arch/arm/mach-omap2/board-3430sdp.c |   19 --
 arch/arm/mach-omap2/board-rx51.c    |   18 +-
 arch/arm/mach-omap2/cpuidle34xx.c   |  436 ++++++++++++-----------------------
 arch/arm/mach-omap2/pm.h            |   17 +-
 arch/arm/mach-omap2/pm34xx.c        |   14 --
 5 files changed, 166 insertions(+), 338 deletions(-)
