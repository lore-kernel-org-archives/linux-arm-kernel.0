From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:01:18 -0700
Subject: [GIT PULL] OMAP: couple more PM fixes for 2.6.37
Message-ID: <1285966880-26448-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Here are a couple more PM related fixes for 2.6.37.  The one from Lo?c
fixes one of the compile errors that's been reported a couple times
now.

This branch is based on my pm-next branch which is already pulled into
your omap-for-linus branch, so should merge smoothly

Kevin


The following changes since commit 0aed043517ad4135cb458a46e9e99e21cbb59c69:

  OMAP: GPIO: ensure debounce clocks are disabled during idle/suspend (2010-09-23 17:14:17 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-next-2

Kevin Hilman (1):
      OMAP3: CPUidle: remove redundant setting of PER next power state

Lo?c Minier (1):
      OMAP: PM: Fix build when CONFIG_PM_DEBUG isn't set

 arch/arm/mach-omap2/cpuidle34xx.c |    4 +---
 arch/arm/mach-omap2/pm.h          |    7 ++++---
 2 files changed, 5 insertions(+), 6 deletions(-)
