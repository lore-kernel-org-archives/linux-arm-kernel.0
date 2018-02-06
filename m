From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 Feb 2018 18:27:57 +0530
Subject: [PATCH v2 06/15] ARM: dts: am57xx-beagle-x15: Add "vqmmc-supply"
 property for mmc2
In-Reply-To: <20180206125806.19350-1-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
Message-ID: <20180206125806.19350-7-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "vqmmc-supply" property for mmc2 to indicate the supply connected
to the IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 441c25677679..7539096fe4d8 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -442,6 +442,7 @@
 	pinctrl-0 = <&mmc2_pins_default>;
 
 	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	bus-width = <8>;
 	ti,non-removable;
 	cap-mmc-dual-data-rate;
-- 
2.11.0
