From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 31 Aug 2016 21:48:14 -0500
Subject: [PATCH v2 1/3] ARM: dts: am33xx: Change operating-points-v2 table to
 am3352 version
In-Reply-To: <20160901024816.32390-1-d-gerlach@ti.com>
References: <20160901024816.32390-1-d-gerlach@ti.com>
Message-ID: <20160901024816.32390-2-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The operating-points-v2 table got merged before the binding had
stabilized so update the compatible string to am3352 version.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 98748c61ed99..a07212914130 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -57,7 +57,7 @@
 	};
 
 	cpu0_opp_table: opp_table0 {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-ti-am3352-cpu";
 
 		/*
 		 * The three following nodes are marked with opp-suspend
-- 
2.9.0
