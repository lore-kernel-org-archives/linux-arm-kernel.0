From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Oct 2009 09:47:18 +0200
Subject: [PATCH 2/6] mx25 devices: Add missing include
In-Reply-To: <1254988042-16737-2-git-send-email-s.hauer@pengutronix.de>
References: <1254988042-16737-1-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1254988042-16737-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx25/devices.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index eb12de1..25c3296 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -1,4 +1,5 @@
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <mach/mx25.h>
 #include <mach/irqs.h>
-- 
1.6.4.3
