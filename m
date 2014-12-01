From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  1 Dec 2014 14:16:33 +0000
Subject: [PATCH] MAINTAINERS: ARM Versatile Express platform,
 add missing pattern
In-Reply-To: <1417442259.4058.5.camel@arm.com>
References: <1417442259.4058.5.camel@arm.com>
Message-ID: <1417443393-16704-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VE's reset driver lives at the third level of the directories:

	drivers/power/reset/vexpress-poweroff.c

and wasn't matched by the */*/vexpress* pattern.

Added additional pattern for all files at this level. This should be
enough for a while...

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 924454f..4a00598 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1512,6 +1512,7 @@ S:	Maintained
 F:	arch/arm/boot/dts/vexpress*
 F:	arch/arm/mach-vexpress/
 F:	*/*/vexpress*
+F:	*/*/*/vexpress*
 F:	drivers/clk/versatile/clk-vexpress-osc.c
 F:	drivers/clocksource/versatile.c
 
-- 
2.1.0
