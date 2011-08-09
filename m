From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 09 Aug 2011 09:07:41 +0100
Subject: [PATCH 10/13] ARM: gpio: pxa: convert drivers to use asm/gpio.h
	rather than mach/gpio.h
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Message-ID: <E1QqhLh-0003ab-Pq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_vpac270.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
index e956f65..66ab92c 100644
--- a/drivers/pcmcia/pxa2xx_vpac270.c
+++ b/drivers/pcmcia/pxa2xx_vpac270.c
@@ -17,7 +17,7 @@
 
 #include <asm/mach-types.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <mach/vpac270.h>
 
 #include "soc_common.h"
-- 
1.7.4.4
