From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Nov 2012 18:56:43 -0800
Subject: [GIT PULL 1/5] omap non critical fixes for v3.8 merge window
Message-ID: <pull-1352948204-277861>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/fixes-non-critical-v4-signed

for you to fetch changes up to 936407358759adb302df93ab61fa68141897270c:

  ARM: OMAP4: PM: fix errata handling when CONFIG_PM=n (2012-11-14 17:06:20 -0800)

----------------------------------------------------------------
Non critical omap fixes that were not considered urgent
for the -rc cycle.

----------------------------------------------------------------
Colin Cross (1):
      ARM: OMAP4: retrigger localtimers after re-enabling gic

Kevin Hilman (1):
      ARM: OMAP4: PM: fix errata handling when CONFIG_PM=n

Santosh Shilimkar (1):
      ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC control register change.

Tero Kristo (1):
      ARM: OMAP4: PM: add errata support

Tony Lindgren (1):
      Merge tag 'for_3.8-fixes-pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.8/fixes-non-critical-v2

 arch/arm/mach-omap2/common.h              |  4 +++
 arch/arm/mach-omap2/omap-headsmp.S        | 38 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |  9 ++++++-
 arch/arm/mach-omap2/omap-smp.c            | 41 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap4-common.c        | 42 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h                  |  9 +++++++
 6 files changed, 140 insertions(+), 3 deletions(-)
