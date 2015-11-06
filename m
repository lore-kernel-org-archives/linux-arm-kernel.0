From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  6 Nov 2015 11:44:29 +0100
Subject: [PATCH] ARM: dts: imx25-pinfunc: add some more pin configurations
Message-ID: <1446806669-32433-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some values that are needed for an out-of-tree device
tree I'm currently working with.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx25-pinfunc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index 7c4b9f2f9aad..848ffa785b63 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -284,6 +284,7 @@
 #define MX25_PAD_CONTRAST__CC4			0x118 0x310 0x000 0x11 0x000
 #define MX25_PAD_CONTRAST__PWM4_PWMO		0x118 0x310 0x000 0x14 0x000
 #define MX25_PAD_CONTRAST__FEC_CRS		0x118 0x310 0x508 0x15 0x001
+#define MX25_PAD_CONTRAST__USBH2_PWR		0x118 0x310 0x000 0x16 0x000
 
 #define MX25_PAD_PWM__PWM			0x11c 0x314 0x000 0x10 0x000
 #define MX25_PAD_PWM__GPIO_1_26			0x11c 0x314 0x000 0x15 0x000
@@ -439,6 +440,7 @@
 #define MX25_PAD_SD1_DATA3__GPIO_2_28		0x1a4 0x39c 0x000 0x15 0x000
 
 #define MX25_PAD_KPP_ROW0__KPP_ROW0		0x1a8 0x3a0 0x000 0x10 0x000
+#define MX25_PAD_KPP_ROW0__UART1_DTR		0x1a8 0x3a0 0x000 0x14 0x000
 #define MX25_PAD_KPP_ROW0__GPIO_2_29		0x1a8 0x3a0 0x000 0x15 0x000
 
 #define MX25_PAD_KPP_ROW1__KPP_ROW1		0x1ac 0x3a4 0x000 0x10 0x000
@@ -446,6 +448,7 @@
 
 #define MX25_PAD_KPP_ROW2__KPP_ROW2		0x1b0 0x3a8 0x000 0x10 0x000
 #define MX25_PAD_KPP_ROW2__CSI_D0		0x1b0 0x3a8 0x488 0x13 0x002
+#define MX25_PAD_KPP_ROW2__UART1_DCD		0x1b0 0x3a8 0x000 0x14 0x000
 #define MX25_PAD_KPP_ROW2__GPIO_2_31		0x1b0 0x3a8 0x000 0x15 0x000
 
 #define MX25_PAD_KPP_ROW3__KPP_ROW3		0x1b4 0x3ac 0x000 0x10 0x000
-- 
2.6.1
