From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Nov 2014 18:07:01 +0000 (UTC)
Subject: [PATCH] MAINTAINERS: add maintainer for OMAP hwmod data
Message-ID: <alpine.DEB.2.02.1411201805530.9204@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I wind up reviewing and committing most of the OMAP hwmod data
patches, so, add myself to MAINTAINERS there so folks will cc me.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Beno?t Cousson <bcousson@baylibre.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c444907ccd69..d904e13a4d54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6716,6 +6716,12 @@ L:	linux-omap at vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-omap2/omap_hwmod.*
 
+OMAP HWMOD DATA
+M:	Paul Walmsley <paul@pwsan.com>
+L:	linux-omap at vger.kernel.org
+S:	Maintained
+F:	arch/arm/mach-omap2/omap_hwmod*data*
+
 OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
 M:	Beno?t Cousson <bcousson@baylibre.com>
 L:	linux-omap at vger.kernel.org
-- 
2.1.3
