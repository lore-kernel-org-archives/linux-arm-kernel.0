From: khilman@ti.com (Kevin Hilman)
Date: Mon, 30 Apr 2012 16:30:01 -0700
Subject: [PATCH 0/3] ARM: OMAP3: clock: cleanup AM35xx clock flags
Message-ID: <1335828604-18795-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all AM35xx specifics from the clock tree and tree and treat all
AM35xx devices the same.

Kevin Hilman (2):
  ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for
    UART4
  ARM: OMAP3: clock data: treat all AM35x devices the same

Paul Walmsley (1):
  ARM: OMAP: clock: convert AM3517/3505 detection/flags to AM35xx

 arch/arm/mach-omap2/clock3xxx_data.c          |   36 +++++++++----------------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    4 +--
 2 files changed, 13 insertions(+), 27 deletions(-)

-- 
1.7.9.2
