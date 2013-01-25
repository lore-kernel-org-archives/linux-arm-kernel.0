From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 25 Jan 2013 08:48:35 +0530
Subject: [PATCH 6/6] ARM: dts: palmas: update dt data for palmas-usb
In-Reply-To: <1359083915-8690-1-git-send-email-kishon@ti.com>
References: <1359083915-8690-1-git-send-email-kishon@ti.com>
Message-ID: <1359083915-8690-7-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update palmas-usb data node in palmas device tree file

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/palmas.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/palmas.dtsi b/arch/arm/boot/dts/palmas.dtsi
index d20adb4..0cf39da 100644
--- a/arch/arm/boot/dts/palmas.dtsi
+++ b/arch/arm/boot/dts/palmas.dtsi
@@ -318,8 +318,8 @@
 
 	palmas_usb {
 		compatible = "ti,palmas-usb";
-		ti,no_control_vbus = <0>;
-		ti,wakeup = <0>;
+		ti,wakeup;
+		vbus-supply = <&smps10_reg>;
 	};
 };
 
-- 
1.7.9.5
