From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 11 May 2010 16:30:46 -0700
Subject: [PATCH 0/6] OMAP GPIO updates for 2.6.35
Message-ID: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A series of OMAP GPIO updates for 2.6.35 from the OMAP PM branch.

Series based on v2.6.34-rc6

Also available here:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git gpio-2.6.35

Kevin

Chunqiu Wang (1):
  OMAP3: GPIO: Only enable WAKEUPEN for edge detection GPIOs

Kevin Hilman (3):
  OMAP2/3: GPIO: generalize prepare for idle
  OMAP3: GPIO: disable GPIO debounce clocks on idle
  OMAP: GPIO: remove duplicate debugfs interface

Tero Kristo (2):
  OMAP3: GPIO fixes for off-mode
  OMAP3: GPIO: Removed a couple of unneeded registers from context
    save/restore

 arch/arm/mach-omap2/pm24xx.c           |    4 +-
 arch/arm/mach-omap2/pm34xx.c           |    4 +-
 arch/arm/plat-omap/gpio.c              |  177 +++++++++-----------------------
 arch/arm/plat-omap/include/plat/gpio.h |    4 +-
 4 files changed, 53 insertions(+), 136 deletions(-)
