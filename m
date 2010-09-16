From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 15 Sep 2010 17:00:12 -0700
Subject: [PATCH v2 0/2] OMAP: runtime PM core for 2.6.37
Message-ID: <1284595214-29155-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A minor re-spin of the runtime PM series,  targetted for 2.6.37.

- rebased to v2.6.36-rc4
- Acks from Grant added
- update for name change of the omap_device parent device
  (c.f. https://patchwork.kernel.org/patch/180152/)

Also available in my pm-runtime branch:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-runtime


Kevin Hilman (2):
  OMAP2+: PM: initial runtime PM core support
  OMAP1: PM: add simple runtime PM layer to manage clocks

 arch/arm/mach-omap1/Makefile |    2 +-
 arch/arm/mach-omap1/pm_bus.c |   98 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile |   10 +++-
 arch/arm/mach-omap2/pm_bus.c |   85 ++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap1/pm_bus.c
 create mode 100644 arch/arm/mach-omap2/pm_bus.c

-- 
1.7.2.1
