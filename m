From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2010 14:26:07 -0800
Subject: [GIT PULL] omap fix for 2.6.33-rc7
Message-ID: <20100211222607.GL21755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull one omap fix from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 80e1e823989ec44d8e35bdfddadbddcffec90424:
  Linus Torvalds (1):
        Fix race in tty_fasync() properly

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Aaro Koskinen (1):
      OMAP: hsmmc: fix memory leak

 arch/arm/mach-omap2/mmc-twl4030.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)
