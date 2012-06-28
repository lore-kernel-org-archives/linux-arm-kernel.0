From: khilman@ti.com (Kevin Hilman)
Date: Thu, 28 Jun 2012 10:20:21 -0700
Subject: [PATCH] MAINTAINERS: add OMAP CPUfreq driver to OMAP Power Management
 section
Message-ID: <1340904021-25872-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the OMAP CPUFreq driver to the list of files in the OMAP Power
Management section.

I've already been maintaining this driver, this just makes it
official.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55f0fda..bee9d2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4836,6 +4836,7 @@ M:	Kevin Hilman <khilman@ti.com>
 L:	linux-omap at vger.kernel.org
 S:	Maintained
 F:	arch/arm/*omap*/*pm*
+F:	drivers/cpufreq/omap-cpufreq.c
 
 OMAP POWERDOMAIN/CLOCKDOMAIN SOC ADAPTATION LAYER SUPPORT
 M:	Rajendra Nayak <rnayak@ti.com>
-- 
1.7.9.2
