From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 2 Sep 2015 16:17:29 +0530
Subject: [PATCH 2/6] ARM: dts: dra7: use "ti,
 pbias-dra7" compatible string for pbias
In-Reply-To: <1441190853-7133-1-git-send-email-kishon@ti.com>
References: <1441190853-7133-1-git-send-email-kishon@ti.com>
Message-ID: <1441190853-7133-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "ti,pbias-dra7" compatible string which is specifically added
for DRA7 SoCs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1e29ccf..d6bc6db 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -122,7 +122,7 @@
 					#size-cells = <1>;
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-dra7", "ti,pbias-omap";
 						reg = <0xe00 0x4>;
 						syscon = <&scm_conf>;
 						pbias_mmc_reg: pbias_mmc_omap5 {
-- 
1.7.9.5
