From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Dec 2017 19:10:49 +0530
Subject: [PATCH 09/14] ARM: dts: dra76-evm: Add "vqmmc-supply" property for
 mmc2
In-Reply-To: <20171214134054.7749-1-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Message-ID: <20171214134054.7749-10-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "vqmmc-supply" property for mmc2 to indicate the supply connected
to the IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index ec8af5841061..4dd8a5ac8fae 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -321,6 +321,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&vio_1v8>;
+	vqmmc-supply = <&vio_1v8>;
 	bus-width = <8>;
 	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
-- 
2.11.0
