From: jean.pihet@newoldbits.com (jean.pihet at newoldbits.com)
Date: Thu, 15 Mar 2012 17:44:01 +0100
Subject: [PATCH 06/10] ARM: OMAP2+: SmartReflex: use the platform header file
 for voltage functions
In-Reply-To: <1331829845-9526-1-git-send-email-j-pihet@ti.com>
References: <1331829845-9526-1-git-send-email-j-pihet@ti.com>
Message-ID: <1331829845-9526-7-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean Pihet <j-pihet@ti.com>

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index f12ebde..8d3e3c2 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -22,7 +22,8 @@
 
 #include <linux/platform_device.h>
 
-#include "voltage.h"
+#include <plat/smartreflex.h>
+#include <plat/voltage.h>
 
 /*
  * Different Smartreflex IPs version. The v1 is the 65nm version used in
-- 
1.7.5.4
