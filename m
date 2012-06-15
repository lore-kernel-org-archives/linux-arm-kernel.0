From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 00:33:02 -0300
Subject: [PATCH 2/5] ARM: dts: mx28evk: Add auart0 and auart3 support
In-Reply-To: <1339731185-4889-1-git-send-email-festevam@gmail.com>
References: <1339731185-4889-1-git-send-email-festevam@gmail.com>
Message-ID: <1339731185-4889-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add auart0 and auart3 support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index ee520a5..41da72a 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -73,6 +73,18 @@
 				pinctrl-0 = <&duart_pins_a>;
 				status = "okay";
 			};
+
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_pins_a>;
+		        	status = "okay";
+			};
+
+			auart3: serial at 80070000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart3_pins_a>;
+		        	status = "okay";
+			};
 		};
 	};
 
-- 
1.7.1
