From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 19 Aug 2015 15:19:46 +0200
Subject: [PATCH 1/2] ARM: imx53: include IRQ dt-bindings header
Message-ID: <1439990387-8602-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows to use the more meaningful IRQ flag defines instead of
the raw values.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c3e3ca9362fb..cd170376eaca 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/imx5-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	aliases {
-- 
2.4.6
