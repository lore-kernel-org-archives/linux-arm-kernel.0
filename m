From: khilman@ti.com (Kevin Hilman)
Date: Fri, 16 Sep 2011 09:50:18 -0700
Subject: [GIT PULL] OMAP PM cleanup for v3.2
Message-ID: <87y5xoqvn9.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following PM cleanups for v3.2

Kevin


The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://gitorious.org/khilman/linux-omap-pm.git for_3.2/pm-cleanup

Johan Hovold (2):
      OMAP2+: PM: fix typos in misc. comment and error messages
      OMAP2+: PM: clean up error messages: replace printk with pr_err.

Kevin Hilman (1):
      OMAP3: PM: fix UART handling when using no_console_suspend

Michael Jones (1):
      OMAP2: PM debug: remove leftover debug code

 arch/arm/mach-omap2/pm.c     |   22 ++++++++++------------
 arch/arm/mach-omap2/pm24xx.c |   27 ---------------------------
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 3 files changed, 11 insertions(+), 40 deletions(-)
