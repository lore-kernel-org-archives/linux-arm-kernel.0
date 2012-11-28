From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 27 Nov 2012 20:15:12 -0600
Subject: [PATCH 0/3] ARM: OMAP2+: Timer build warnings and error fixes
Message-ID: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes for build warnings and errors seen with various kernel
configuration combinations.

Jon Hunter (3):
  ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
  ARM: OMAP4: Fix build error and warning in timer.c
  ARM: AM335x: Fix warning in timer.c

 arch/arm/mach-omap2/Kconfig |    4 ----
 arch/arm/mach-omap2/timer.c |   12 ++++++------
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
1.7.10.4
