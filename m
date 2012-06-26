From: khilman@ti.com (Kevin Hilman)
Date: Tue, 26 Jun 2012 07:48:35 -0500
Subject: [GIT PULL] OMAP PM: misc. cleanup for v3.6
Message-ID: <87d34mdysc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following misc. PM cleanups for v3.6.

Kevin

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.6/cleanup/pm

for you to fetch changes up to b110547e586eb5825bc1d04aa9147bff83b57672:

  ARM: OMAP2+: OPP: Fix to ensure check of right oppdef after bad one (2012-06-19 15:23:29 -0700)

----------------------------------------------------------------
Daniel Lezcano (1):
      ARM: OMAP3/4: consolidate cpuidle Makefile

Mark A. Greer (1):
      ARM: OMAP3: PM: Only access IVA if one exists

Nishanth Menon (1):
      ARM: OMAP2+: OPP: Fix to ensure check of right oppdef after bad one

 arch/arm/mach-omap2/Kconfig       |    2 ++
 arch/arm/mach-omap2/Makefile      |    7 +++++--
 arch/arm/mach-omap2/cpuidle34xx.c |    8 --------
 arch/arm/mach-omap2/cpuidle44xx.c |    8 --------
 arch/arm/mach-omap2/opp.c         |    3 +--
 arch/arm/mach-omap2/pm.h          |   17 +++++++++++++++--
 arch/arm/mach-omap2/pm34xx.c      |   15 ++++++++++-----
 7 files changed, 33 insertions(+), 27 deletions(-)
