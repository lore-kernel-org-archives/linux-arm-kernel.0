From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Dec 2017 19:10:48 +0530
Subject: [PATCH 08/14] ARM: dts: am57xx-idk: Add "vqmmc-supply" property for
 mmc2
In-Reply-To: <20171214134054.7749-1-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Message-ID: <20171214134054.7749-9-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "vqmmc-supply" property for mmc2 to indicate the supply connected
to the IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 97aa8e6a56da..43a6d0590f7c 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -410,6 +410,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&v3_3d>;
+	vqmmc-supply = <&v3_3d>;
 	bus-width = <8>;
 	ti,non-removable;
 	max-frequency = <96000000>;
-- 
2.11.0
