From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 12 Nov 2014 11:50:28 +0900
Subject: [PATCHv2 1/2] ARM: dts: Fix the number of DMA channels for Exynos3250
In-Reply-To: <1415760629-1531-1-git-send-email-cw00.choi@samsung.com>
References: <1415760629-1531-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1415760629-1531-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the numer for DMA channels for Exynos3250 because DMA controller
of Exynos3250 can support 16 channels simultaneously.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 242ddda..5c14e3e 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -292,7 +292,7 @@
 				clocks = <&cmu CLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
-				#dma-channels = <8>;
+				#dma-channels = <16>;
 				#dma-requests = <32>;
 			};
 
@@ -303,7 +303,7 @@
 				clocks = <&cmu CLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
-				#dma-channels = <8>;
+				#dma-channels = <16;
 				#dma-requests = <32>;
 			};
 		};
-- 
1.8.5.5
