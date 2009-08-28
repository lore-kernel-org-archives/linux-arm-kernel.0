From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 28 Aug 2009 11:28:45 +0300
Subject: [PATCH 0/2] OMAP: misc. fixes for 2.6.32
Message-ID: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

I pushed a couple more fixes to my pm-upstream/fixes-32 branch.  You've
already pulled this branch into your for-next, so a re-pull will get
you just these two additional patches.

Thanks,

Kevin


Reddy, Teerth (1):
  OMAP3: PM: add T2 interrupt line mux setting, and enable on 3430SDP

Vikram Pandita (1):
  OMAP: Zoom2: release debug board detect gpio line

 arch/arm/mach-omap2/board-3430sdp.c         |    6 ++++++
 arch/arm/mach-omap2/board-zoom-debugboard.c |    7 ++++---
 arch/arm/mach-omap2/mux.c                   |    5 +++++
 arch/arm/plat-omap/include/mach/mux.h       |    3 +++
 4 files changed, 18 insertions(+), 3 deletions(-)
