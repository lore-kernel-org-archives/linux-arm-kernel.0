From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Thu, 12 Dec 2013 08:32:02 +0530
Subject: [PATCH 3/3] ARM: dts: Fix MDMA0 clock number
In-Reply-To: <1386817322-11265-1-git-send-email-a.kesavan@samsung.com>
References: <1386817322-11265-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1386817322-11265-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix wrong clock number in mdma0 node.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 9db5047..177becd 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -559,7 +559,7 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10800000 0x1000>;
 			interrupts = <0 33 0>;
-			clocks = <&clock 271>;
+			clocks = <&clock 346>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
 			#dma-channels = <8>;
-- 
1.7.9.5
