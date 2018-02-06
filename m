From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 Feb 2018 18:27:59 +0530
Subject: [PATCH v2 08/15] ARM: dts: dra7-evm: Add "vqmmc-supply" property for
 mmc2
In-Reply-To: <20180206125806.19350-1-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
Message-ID: <20180206125806.19350-9-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "vqmmc-supply" property for mmc2 to indicate the supply connected
to the IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index a2769115c8a5..f1425b0f3a54 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -323,6 +323,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&evm_1v8_sw>;
+	vqmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
 	pinctrl-names = "default", "hs", "ddr_1_8v-rev11", "ddr_1_8v", "hs200_1_8v-rev11", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
-- 
2.11.0
