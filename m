From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 11 Mar 2018 19:00:07 +0300
Subject: [PATCH 7/8] ARM: dts: berlin2cd: add a label for the CPU node
In-Reply-To: <20180311160008.22928-1-amonakov@ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
Message-ID: <20180311160008.22928-8-amonakov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is useful if the board file needs to reference it.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index c1da34c3c32c..92811d61e669 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -57,7 +57,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
-- 
2.11.0
