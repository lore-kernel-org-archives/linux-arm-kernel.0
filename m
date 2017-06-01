From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 22:46:28 +0200
Subject: [PATCH 0/5] ARM-OMAP1: Adjustments for three function implementations
Message-ID: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 22:40:04 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Improve a size determination in omap1_system_dma_init()
  Delete an error message for a failed memory allocation in omap1_system_dma_init()
  Delete an unnecessary return statement in omap1_show_dma_caps()
  Delete an error message for a failed memory allocation in omap1_dm_timer_init()
  Fix a typo in a comment line

 arch/arm/mach-omap1/dma.c   | 5 +----
 arch/arm/mach-omap1/timer.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

-- 
2.13.0
