From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 28 Nov 2012 16:04:56 -0600
Subject: [PATCH V2 0/4] ARM: OMAP2+: Timer build warnings and error fixes
Message-ID: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes for build warnings and errors seen with various kernel
configuration combinations. Based upon Tony Lindgren's OMAP
master branch.

V2 changes:
- Update fix for realtime counter per feedback from Santosh
- Update fix when building for only AM335x with Igor's suggestion to
  use __maybe_unused (thanks Igor!)
- Add Vaibhav's fixes for sparse warnings

Jon Hunter (3):
  ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
  ARM: OMAP4: Fix build error and warning in timer.c
  ARM: AM335x: Fix warning in timer.c

Vaibhav Hiremath (1):
  ARM: OMAP2+: Fix sparse warnings in timer.c

 arch/arm/mach-omap2/Kconfig |    3 ++-
 arch/arm/mach-omap2/timer.c |    8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
1.7.10.4
