From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Sep 2012 19:18:43 -0700
Subject: [GIT PULL 1/7] omap non-critical fixes for v3.7 merge window
Message-ID: <pull-1347589125-283636>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-noncritical-for-v3.7

for you to fetch changes up to 3c5dc4a7daa6e64e39412fe9c7daa298834de623:

  ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT* read/write (2012-09-12 21:14:34 -0700)

----------------------------------------------------------------
Non critical omap fixes that we not considered necessary
for the v3.6 -rc cycle.

----------------------------------------------------------------
Paul Walmsley (1):
      ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT* read/write

Santosh Shilimkar (1):
      ARM: OMAP4: wakeupgen: Fix the typo in AUXCOREBOOT register save

Wei Yongjun (1):
      gpio/omap: fix possible memory leak in omap2_gpio_dev_init()

 arch/arm/mach-omap2/gpio.c           |    2 ++
 arch/arm/mach-omap2/omap-wakeupgen.c |    8 +-------
 2 files changed, 3 insertions(+), 7 deletions(-)
