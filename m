From: rabel@cit-ec.uni-bielefeld.de (Robert ABEL)
Date: Thu, 12 Feb 2015 18:13:30 +0100
Subject: [PATCH] ARM OMAP2 GPMC: don't undef DEBUG
In-Reply-To: <1423761210-24452-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1423761210-24452-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Message-ID: <1423761210-24452-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 arch/arm/mach-omap2/gpmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ab43755..1ab6bc0 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -12,8 +12,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#undef DEBUG
-
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.3.0
