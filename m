From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 26 Feb 2018 17:04:59 +0200
Subject: [PATCH 1/2] ARM: dts: am33xx: add emif interrupt info
In-Reply-To: <1519657500-15490-1-git-send-email-t-kristo@ti.com>
References: <1519657500-15490-1-git-send-email-t-kristo@ti.com>
Message-ID: <1519657500-15490-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EMIF instance on am33xx supports interrupts, so add the info for
completeness sake. Right now, the driver does not use this for anything,
but it is possible it would be used in future.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 628c77b..2c09e8b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -945,6 +945,7 @@
 			compatible = "ti,emif-am3352";
 			reg = <0x4c000000 0x1000000>;
 			ti,hwmods = "emif";
+			interrupts = <101>;
 		};
 
 		gpmc: gpmc at 50000000 {
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
