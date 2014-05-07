From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  7 May 2014 15:31:26 +0200
Subject: [PATCH 3/6] ARM: dts: i.MX25: Add IRAM node
In-Reply-To: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
References: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1399469489-22788-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 399b25b..07aff54 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -531,6 +531,11 @@
 			};
 		};
 
+		iram: sram at 78000000 {
+			compatible = "mmio-sram";
+			reg = <0x78000000 0x20000>;
+		};
+
 		emi at 80000000 {
 			compatible = "fsl,emi-bus", "simple-bus";
 			#address-cells = <1>;
-- 
2.0.0.rc0
