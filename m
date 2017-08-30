From: embed3d@gmail.com (Philipp Rossak)
Date: Wed, 30 Aug 2017 05:01:09 +0200
Subject: [PATCH 6/7] ARM: dts: sun8i: h3: Adding UART3 RTS and CTS Pins
In-Reply-To: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
References: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
Message-ID: <1504062070-13523-7-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

This node adds the definition for the UART3 RTS and CTS Pins

That makes it able to use UART3 with RTS and CTS.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index d38282b..7f750ef 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -381,6 +381,11 @@
 				pins = "PA13", "PA14";
 				function = "uart3";
 			};
+
+			uart3_rts_cts_pins: uart3_rts_cts {
+				pins = "PA15", "PA16";
+				function = "uart3";
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.7.4
