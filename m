From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 12 Mar 2012 20:04:31 +0530
Subject: [PATCH 0/2] ARM: OMAP4: powerdomain: Misc powerdomain fix and
 associated cleanup
Message-ID: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,
Can you please have at this series ?
First patch is the bug fix and second one is the cleanup which you proposed some
time back.

Santosh Shilimkar (2):
  ARM: OMAP: powerdomain: Wait for powerdomain transition in
    pwrdm_state_switch()
  ARM: OMAP: powerdomain: Get rid off duplicate
    pwrdm_clkdm_state_switch() API

 arch/arm/mach-omap2/clock.c       |    2 +-
 arch/arm/mach-omap2/clockdomain.c |    7 +++----
 arch/arm/mach-omap2/powerdomain.c |   14 +++++---------
 arch/arm/mach-omap2/powerdomain.h |    1 -
 4 files changed, 9 insertions(+), 15 deletions(-)

-- 
1.7.4.1
