From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 26 Nov 2012 16:21:19 +0530
Subject: [PATCH] Input: omap4-keypad: Remove the OMAP4_KBD_SYSCONFIG and
 OMAP4_KBD_SYSSTATUS
Message-ID: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macros OMAP4_KBD_SYSSTATUS and OMAP4_KBD_SYSSTATUS are not used
so remove them.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/input/keyboard/omap4-keypad.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index c05f98c..d2b72b7 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -36,8 +36,6 @@
 
 /* OMAP4 registers */
 #define OMAP4_KBD_REVISION		0x00
-#define OMAP4_KBD_SYSCONFIG		0x10
-#define OMAP4_KBD_SYSSTATUS		0x14
 #define OMAP4_KBD_IRQSTATUS		0x18
 #define OMAP4_KBD_IRQENABLE		0x1C
 #define OMAP4_KBD_WAKEUPENABLE		0x20
-- 
1.7.5.4
