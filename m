From: joe@perches.com (Joe Perches)
Date: Sat, 26 Sep 2009 11:47:04 -0700
Subject: [PATCH] MAINTAINERS: ARM/Palm file patterns
Message-ID: <1253990824.7128.25.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek.

For the section you maintain, are these file patterns correct?

diff --git a/MAINTAINERS b/MAINTAINERS
index c450f3a..f91ac61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -741,11 +741,12 @@ M:	Dirk Opfer <dirk@opfer-online.de>
 S:	Maintained
 
 ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
-P:	Marek Vasut
-M:	marek.vasut at gmail.com
+M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org
 W:	http://hackndev.com
 S:	Maintained
+F:	arch/arm/mach-pxa/include/mach/palm*
+F:	arch/arm/mach-pxa/palm*
 
 ARM/PALM TREO 680 SUPPORT
 M:	Tomas Cech <sleep_walker@suse.cz>
