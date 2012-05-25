From: khilman@ti.com (Kevin Hilman)
Date: Fri, 25 May 2012 15:53:19 -0700
Subject: [PATCH] MAINTAINERS: add OMAP CPUfreq driver to OMAP Power Management
 section
Message-ID: <1337986399-32607-1-git-send-email-khilman@ti.com>
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
index b362709..60ff5d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4791,6 +4791,7 @@ M:	Kevin Hilman <khilman@ti.com>
 L:	linux-omap at vger.kernel.org
 S:	Maintained
 F:	arch/arm/*omap*/*pm*
+F:	drivers/cpufreq/omap-cpufreq.c
 
 OMAP POWERDOMAIN/CLOCKDOMAIN SOC ADAPTATION LAYER SUPPORT
 M:	Rajendra Nayak <rnayak@ti.com>
-- 
1.7.9.2
