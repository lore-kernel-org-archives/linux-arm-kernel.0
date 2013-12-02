From: voice.shen@atmel.com (Bo Shen)
Date: Mon,  2 Dec 2013 16:29:48 +0800
Subject: [PATCH] arm: at91: sama5d3: enable qt1070 as a wakeup source
Message-ID: <1385972988-20157-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable qt1070 keyboard as a wakeup source on sama5d3xek board.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/sama5d3xdm.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
index 1c296d6..f9bdde5 100644
--- a/arch/arm/boot/dts/sama5d3xdm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xdm.dtsi
@@ -18,6 +18,7 @@
 					interrupts = <31 0x0>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_qt1070_irq>;
+					wakeup-source;
 				};
 			};
 
-- 
1.7.9.5
