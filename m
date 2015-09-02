From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 2 Sep 2015 16:17:33 +0530
Subject: [PATCH 6/6] ARM: dts: OMAP5: use "ti,
 pbias-omap5" compatible string for pbias
In-Reply-To: <1441190853-7133-1-git-send-email-kishon@ti.com>
References: <1441190853-7133-1-git-send-email-kishon@ti.com>
Message-ID: <1441190853-7133-7-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "ti,pbias-omap5" compatible string which is specifically added
for OMAP5.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b1a1263..76ef595 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -187,7 +187,7 @@
 					#size-cells = <1>;
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-omap5", "ti,pbias-omap";
 						reg = <0x60 0x4>;
 						syscon = <&omap5_padconf_global>;
 						pbias_mmc_reg: pbias_mmc_omap5 {
-- 
1.7.9.5
