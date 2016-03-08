From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  8 Mar 2016 09:26:13 -0300
Subject: [PATCH 2/3] ARM: dts: imx6sx: Remove unused property
In-Reply-To: <1457439974-1149-1-git-send-email-festevam@gmail.com>
References: <1457439974-1149-1-git-send-email-festevam@gmail.com>
Message-ID: <1457439974-1149-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Property 'dma-source' is not used anywhere, not it is documented, so
let's just get rid of it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index c8269e7..d02ab32 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -971,7 +971,6 @@
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
 				dma-names = "rx", "tx";
 				dmas = <&sdma 31 24 0>, <&sdma 32 24 0>;
-				dma-source = <&gpr 0 15 0 16>;
 				status = "disabled";
 			};
 
@@ -991,7 +990,6 @@
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
 				dma-names = "rx", "tx";
 				dmas = <&sdma 33 24 0>, <&sdma 34 24 0>;
-				dma-source = <&gpr 0 17 0 18>;
 				status = "disabled";
 			};
 
-- 
1.9.1
