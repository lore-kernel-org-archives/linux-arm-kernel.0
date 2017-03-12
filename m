From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Mar 2017 00:28:14 +0100
Subject: [PATCH 2/6] ARM: dts: augment Gemini GPIO nodes
In-Reply-To: <20170312232818.26304-1-linus.walleij@linaro.org>
References: <20170312232818.26304-1-linus.walleij@linaro.org>
Message-ID: <20170312232818.26304-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding should state "cortina,gemini-gpio", "faraday,ftgpio010"
stating the full name of the IP part.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 67c0a63d5527..b8d011bdcc76 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -82,7 +82,7 @@
 		};
 
 		gpio0: gpio at 4d000000 {
-			compatible = "cortina,gemini-gpio";
+			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4d000000 0x100>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -92,7 +92,7 @@
 		};
 
 		gpio1: gpio at 4e000000 {
-			compatible = "cortina,gemini-gpio";
+			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4e000000 0x100>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -102,7 +102,7 @@
 		};
 
 		gpio2: gpio at 4f000000 {
-			compatible = "cortina,gemini-gpio";
+			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4f000000 0x100>;
 			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
-- 
2.9.3
