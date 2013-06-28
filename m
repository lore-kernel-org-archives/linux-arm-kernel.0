From: b32955@freescale.com (Huang Shijie)
Date: Fri, 28 Jun 2013 17:07:34 +0800
Subject: [PATCH] ARM: dts: imx: remove the unused property
Message-ID: <1372410454-14628-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "fsl,gpmi-dma-channel" is not used any more, just remove it
from all the dts file.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx23.dtsi   |    1 -
 arch/arm/boot/dts/imx28.dtsi   |    1 -
 arch/arm/boot/dts/imx6qdl.dtsi |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 587ceef..399b0a0 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -82,7 +82,6 @@
 				clock-names = "gpmi_io";
 				dmas = <&dma_apbh 4>;
 				dma-names = "rx-tx";
-				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 6a8acb0..cc65572 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -104,7 +104,6 @@
 				clock-names = "gpmi_io";
 				dmas = <&dma_apbh 4>;
 				dma-names = "rx-tx";
-				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index f2c623d..0641652 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -89,7 +89,6 @@
 				      "gpmi_bch_apb", "per1_bch";
 			dmas = <&dma_apbh 0>;
 			dma-names = "rx-tx";
-			fsl,gpmi-dma-channel = <0>;
 			status = "disabled";
 		};
 
-- 
1.7.1
