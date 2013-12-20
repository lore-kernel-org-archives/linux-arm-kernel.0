From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 20 Dec 2013 20:39:03 +0100
Subject: [PATCH] MAINTAINERS: take maintainership for Energy Micro efm32 SoCs
Message-ID: <1387568343-8754-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I think this can best go in via armsoc, but needs acks for clk, clocksource,
spi and tty/serial.

Best regards
Uwe

 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95648eb..28c69a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -867,6 +867,21 @@ S:	Maintained
 F:	arch/arm/mach-ebsa110/
 F:	drivers/net/ethernet/amd/am79c961a.*
 
+ARM/ENERGY MICRO (SILICON LABS) EFM32 SUPPORT
+M:	Uwe Kleine-K?nig <kernel@pengutronix.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/efm32*
+F:	arch/arm/configs/efm32_defconfig
+F:	arch/arm/include/debug/efm32.S
+F:	arch/arm/mach-efm32/
+F:	drivers/clk/clk-efm32gg.c
+F:	drivers/clocksource/time-efm32.c
+F:	drivers/spi/spi-efm32.c
+F:	drivers/tty/serial/efm32-uart.c
+F:	include/dt-bindings/clock/efm32-cmu.h
+F:	include/linux/platform_data/efm32-*
+
 ARM/EZX SMARTPHONES (A780, A910, A1200, E680, ROKR E2 and ROKR E6)
 M:	Daniel Ribeiro <drwyrm@gmail.com>
 M:	Stefan Schmidt <stefan@openezx.org>
-- 
1.8.5.1
