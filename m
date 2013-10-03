From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:29:34 +0200
Subject: [PATCH 01/10] ARM: ux500: add default trigger on HREF LED
Message-ID: <1380799774-25730-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a heartbeat on the first LED on the ux500 HREF
boards.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index f88a659..5e7cf4b 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -72,6 +72,7 @@
 				chan0 {
 					led-cur = /bits/ 8 <0x2f>;
 					max-cur = /bits/ 8 <0x5f>;
+					linux,default-trigger = "heartbeat";
 				};
 				chan1 {
 					led-cur = /bits/ 8 <0x2f>;
-- 
1.8.3.1
