From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Thu, 16 Feb 2012 15:43:53 +0100
Subject: [PATCH] arch/arm/plat-omap/clock.c: included linux/debugfs.h twice
Message-ID: <1329403433-32327-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/plat-omap/clock.c: included 'linux/debugfs.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/plat-omap/clock.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 567e4b5..56b6f8b 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -20,7 +20,6 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 #include <linux/cpufreq.h>
-#include <linux/debugfs.h>
 #include <linux/io.h>
 
 #include <plat/clock.h>
-- 
1.7.8.3
