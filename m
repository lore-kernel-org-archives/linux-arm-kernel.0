From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 26 Oct 2009 23:04:25 +0100
Subject: [PATCH 1/2] ep93xx/micro9.c: fix implicit declaration of function
	__raw_readl and IOMEM
Message-ID: <1256594665-9837-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-ep93xx/micro9.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index d83b804..f3757a1 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 
-- 
1.6.4
