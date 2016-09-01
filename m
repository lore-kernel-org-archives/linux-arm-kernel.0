From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 31 Aug 2016 21:48:16 -0500
Subject: [PATCH v2 3/3] ARM: dts: dra7: Change operating-points-v2 table to
 dra7 version
In-Reply-To: <20160901024816.32390-1-d-gerlach@ti.com>
References: <20160901024816.32390-1-d-gerlach@ti.com>
Message-ID: <20160901024816.32390-4-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The operating-points-v2 table got merged before the binding had
stabilized so update the compatible string to dra7 version.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d9bfb94a2992..c138eca85efd 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -99,7 +99,7 @@
 	};
 
 	cpu0_opp_table: opp_table0 {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-ti-dra7-cpu";
 		opp-shared;
 
 		opp_nom at 1000000000 {
-- 
2.9.0
