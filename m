From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  1 Mar 2018 21:34:59 +0100
Subject: [PATCH] ARM: dts: exynos: Remove unused bypass-smu property from
 Xyref5260
Message-ID: <1519936499-23230-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bypass-smu property is neither used nor documented in bindings.
Remove it from Xyref5260 board DTS.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5260-xyref5260.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 442eb0353f29..fa19c59b2fb6 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -65,7 +65,6 @@
 &mmc_0 {
 	status = "okay";
 	broken-cd;
-	bypass-smu;
 	cap-mmc-highspeed;
 	supports-hs200-mode; /* 200 MHz */
 	card-detect-delay = <200>;
-- 
2.7.4
