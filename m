From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue,  5 Feb 2013 16:10:25 +0100
Subject: [PATCH] ARM: Kirkwood: Add missing linux/i2c.h include
Message-ID: <1360077025-8046-1-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nsa310 board uses I2C_BOARD_INFO and i2c_register_board_info(), both
of which are defined in the linux/i2c.h header file.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/mach-kirkwood/board-nsa310.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
index 61c4b18..970174a 100644
--- a/arch/arm/mach-kirkwood/board-nsa310.c
+++ b/arch/arm/mach-kirkwood/board-nsa310.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
 #include <mach/kirkwood.h>
 #include <linux/of.h>
 #include "common.h"
-- 
1.8.1.2
