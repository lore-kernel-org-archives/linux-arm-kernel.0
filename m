From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Apr 2016 11:00:48 +0900
Subject: [PATCH v2 09/11] ARM: dts: exynos: Fix DTC unit name warnings in
 SMDK5420
In-Reply-To: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
References: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459908050-16430-9-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in Exynos5420 SMDK5420:

Warning (unit_address_vs_reg): Node /dp-controller at 145B0000/display-timings/timing at 0 has a unit name, but no reg property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's tag.
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 0785fedf441e..99160f796851 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -111,7 +111,7 @@
 
 	display-timings {
 		native-mode = <&timing0>;
-		timing0: timing at 0 {
+		timing0: timing {
 			clock-frequency = <50000>;
 			hactive = <2560>;
 			vactive = <1600>;
-- 
2.5.0
