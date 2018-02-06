From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 Feb 2018 18:28:01 +0530
Subject: [PATCH v2 10/15] ARM: dts: dra76-evm: Add "vqmmc-supply" property for
 mmc2
In-Reply-To: <20180206125806.19350-1-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
Message-ID: <20180206125806.19350-11-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "vqmmc-supply" property for mmc2 to indicate the supply connected
to the IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 088853001c81..2deb96405d06 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -322,6 +322,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&vio_1v8>;
+	vqmmc-supply = <&vio_1v8>;
 	bus-width = <8>;
 	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
-- 
2.11.0
