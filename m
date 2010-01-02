From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:21:52 +0000
Subject: [PATCH 17/18] ARM: PNX4008: i2c-pnx makes no use of asm/uaccess.h nor
	asm/irq.h
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <15fc3233da81cf4beb4cea4edc476d06bc114bd5.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary includes

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-pnx.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index a71cd93..34c5994 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -25,8 +25,6 @@
 
 #include <mach/hardware.h>
 #include <mach/i2c.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
 
 #define I2C_PNX_TIMEOUT		10 /* msec */
 #define I2C_PNX_SPEED_KHZ	100
-- 
1.6.2.5
