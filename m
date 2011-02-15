From: premi@ti.com (Sanjeev Premi)
Date: Tue, 15 Feb 2011 16:27:30 +0530
Subject: [PATCH 0/2] omap3: minor clean-up in flash related code
Message-ID: <1297767452-22554-1-git-send-email-premi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes include:
 - fixing typos
 - using pr_err() instead of printk

Sanjeev Premi (2):
  omap3: fix minor typos
  omap3: flash: use pr_err instead of printk

 arch/arm/mach-omap2/board-flash.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

-- 
1.7.2.2
