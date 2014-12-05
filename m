From: alexanders83@web.de (Alexander Stein)
Date: Fri,  5 Dec 2014 15:16:56 +0100
Subject: [PATCH 2/2] ARM: at91/dt: sam9263: Add missing clocks to ac97 node
In-Reply-To: <1417789016-20001-1-git-send-email-alexanders83@web.de>
References: <1417789016-20001-1-git-send-email-alexanders83@web.de>
Message-ID: <1417789016-20001-2-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock node specifying 'ac97_clk' was missing.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 5ed2810..2d9d0ad 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -821,6 +821,8 @@
 				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ac97>;
+				clocks = <&ac97_clk>;
+				clock-names = "ac97_clk";
 				status = "disabled";
 			};
 
-- 
2.2.0
