From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed,  6 Jul 2011 20:34:43 +0800
Subject: [PATCH 13/17] plat-samsung: remove including old leds event API
	header file
In-Reply-To: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1309955687-19365-14-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/plat-samsung/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
index 2231d80..bd9d42d 100644
--- a/arch/arm/plat-samsung/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -29,7 +29,6 @@
 #include <linux/platform_device.h>
 
 #include <asm/system.h>
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 
 #include <asm/irq.h>
-- 
1.7.5
