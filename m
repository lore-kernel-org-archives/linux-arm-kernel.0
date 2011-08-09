From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 09 Aug 2011 09:07:01 +0100
Subject: [PATCH 08/13] ARM: gpio: ixp2000: convert drivers to use asm/gpio.h
	rather than mach/gpio.h
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Message-ID: <E1QqhL3-0003aT-HT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-ixp2000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
index 5d8aed5..be9991b 100644
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -35,7 +35,7 @@
 #include <linux/slab.h>
 
 #include <mach/hardware.h>	/* Pick up IXP2000-specific bits */
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 static inline int ixp2000_scl_pin(void *data)
 {
-- 
1.7.4.4
