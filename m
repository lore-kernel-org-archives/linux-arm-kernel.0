From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 20 Dec 2015 04:26:55 +0200
Subject: [PATCH] arm: dts: am335x-pepper: fix typo in vmmc-supply property name
Message-ID: <1450578415-29388-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial fix of a typo, vmmc-supply should be the right property name.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/am335x-pepper.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 7106114..a137487 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -351,7 +351,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wireless_pins>;
-	vmmmc-supply = <&v3v3c_reg>;
+	vmmc-supply = <&v3v3c_reg>;
 	bus-width = <4>;
 	ti,non-removable;
 	dmas = <&edma 12
-- 
2.1.4
