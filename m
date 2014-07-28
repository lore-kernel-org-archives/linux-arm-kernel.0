From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Jul 2014 21:44:02 +0900
Subject: [PATCHv2 3/3] dt-bindings: samsung: exynos_adc: Remove un-necessary
 white-sapce
In-Reply-To: <1406551442-15186-1-git-send-email-cw00.choi@samsung.com>
References: <1406551442-15186-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1406551442-15186-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch remove un-necessary white-sapce to code clean.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
index 709efaa..5ee0266 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
@@ -30,7 +30,7 @@ Required properties:
 			- The base address and range of ADC register
 			- The base address and range of ADC_PHY register (every
 			  SoC except for s3c24xx/s3c64xx ADC)
-- interrupts: 		Contains the interrupt information for the timer. The
+- interrupts:		Contains the interrupt information for the timer. The
 			format is being dependent on which interrupt controller
 			the Samsung device uses.
 - #io-channel-cells = <1>; As ADC has multiple outputs
-- 
1.8.0
