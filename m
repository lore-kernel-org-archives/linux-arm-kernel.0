From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  6 Jan 2017 09:02:52 +0200
Subject: [PATCH] arm64: dts: exynos: Remove unsupported regulator-always-off
 property from TM2E
Message-ID: <20170106070252.6008-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator property 'regulator-always-off' is not documented and not
supported.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
index 1db4e7f363a9..398f5e092b02 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
@@ -25,7 +25,6 @@
 
 &ldo25_reg {
 	regulator-name = "UNUSED_LDO25";
-	regulator-always-off;
 };
 
 &ldo31_reg {
-- 
2.9.3
