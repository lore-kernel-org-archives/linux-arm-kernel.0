From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 19 Dec 2017 09:24:22 -0600
Subject: [PATCH 4/8] ARM: dts: am57xx-beagle-x15-common: Add cpu0 vdd supply
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1513697066-27732-5-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vdd-supply as smps12_reg for cpu0.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 49aeecd312b4..441c25677679 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -388,7 +388,7 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&smps12_reg>;
+	vdd-supply = <&smps12_reg>;
 	voltage-tolerance = <1>;
 };
 
-- 
2.15.1
