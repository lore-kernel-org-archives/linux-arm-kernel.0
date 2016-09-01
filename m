From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 31 Aug 2016 21:48:15 -0500
Subject: [PATCH v2 2/3] ARM: dts: am4372: Change operating-points-v2 table to
 am4372 version
In-Reply-To: <20160901024816.32390-1-d-gerlach@ti.com>
References: <20160901024816.32390-1-d-gerlach@ti.com>
Message-ID: <20160901024816.32390-3-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The operating-points-v2 table got merged before the binding had
stabilized so update the compatible string to am4372 version.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0fadae5396e1..cdadcd793229 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -53,7 +53,7 @@
 	};
 
 	cpu0_opp_table: opp_table0 {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-ti-am4372-cpu";
 
 		opp50 at 300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-- 
2.9.0
