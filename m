From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Jul 2014 11:58:50 -0300
Subject: [PATCH v2 2/4] ARM: dts: imx6sx: Pass the fsl,fifo-depth property
In-Reply-To: <1404313132-14400-1-git-send-email-festevam@gmail.com>
References: <1404313132-14400-1-git-send-email-festevam@gmail.com>
Message-ID: <1404313132-14400-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Like the other mx6 variants, we need to pass fsl,fifo-depth property in dtsi.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Only add fifo-depth and keep the clocks as before

 arch/arm/boot/dts/imx6sx.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 2929078..92d48be 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -306,6 +306,7 @@
 					clock-names = "ipg", "baud";
 					dmas = <&sdma 37 1 0>, <&sdma 38 1 0>;
 					dma-names = "rx", "tx";
+					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
 
@@ -318,6 +319,7 @@
 					clock-names = "ipg", "baud";
 					dmas = <&sdma 41 1 0>, <&sdma 42 1 0>;
 					dma-names = "rx", "tx";
+					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
 
@@ -330,6 +332,7 @@
 					clock-names = "ipg", "baud";
 					dmas = <&sdma 45 1 0>, <&sdma 46 1 0>;
 					dma-names = "rx", "tx";
+					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
 
-- 
1.8.3.2
