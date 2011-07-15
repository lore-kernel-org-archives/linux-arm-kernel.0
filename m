From: BJulin@clarku.edu (Brian Julin)
Date: Fri, 15 Jul 2011 18:12:44 -0400
Subject: [PATCH] freshen up mm/proc-arm946.S
Message-ID: <5A630F46702DD1498FFD48394B4A664CB39A93520F@john.ad.clarku.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch helps get  things compiling/working when ARM946 is selected.  It fixes a 
missing structure member and a typo in mm/proc-arm946.S

Signed-off-by: Brian S. Julin <bri@abrij.org>
--- a/arch/arm/mm/proc-arm946.S	2011-07-14 15:00:27.000000000 -0400
+++ b/arch/arm/mm/proc-arm946.S	2011-07-10 14:27:13.000000000 -0400
@@ -450,4 +450,5 @@
 	.long	0xff00fff0
 	.long	0
+	.long	0
 	b	__arm946_setup
 	.long	cpu_arch_name
@@ -458,5 +459,5 @@
 	.long	0
 	.long	0
-	.long	arm940_cache_fns
+	.long	arm946_cache_fns
 	.size	__arm946_proc_info, . - __arm946_proc_info
 
