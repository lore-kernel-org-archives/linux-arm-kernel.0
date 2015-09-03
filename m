From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Sep 2015 12:20:38 +0530
Subject: [PATCH v2 2/6] ARM: dts: dra7: use "ti,
 pbias-dra7" compatible string for pbias
In-Reply-To: <1441263042-12942-1-git-send-email-kishon@ti.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
Message-ID: <1441263042-12942-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "ti,pbias-dra7" compatible string which is specifically added
for DRA7 SoCs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
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
