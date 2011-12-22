From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 22 Dec 2011 15:56:40 +0100
Subject: [PATCH v4 06/12] arm/dts: OMAP3: Add i2c controller nodes
In-Reply-To: <1324565806-31142-1-git-send-email-b-cousson@ti.com>
References: <1324565806-31142-1-git-send-email-b-cousson@ti.com>
Message-ID: <1324565806-31142-7-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c controllers nodes into the main ocp bus.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 6866dc7..697b210 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -61,5 +61,26 @@
 			ti,intc-size = <96>;
 			reg = <0x48200000 0x1000>;
 		};
+
+		i2c1: i2c at 1 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c1";
+		};
+
+		i2c2: i2c at 2 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c2";
+		};
+
+		i2c3: i2c at 3 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c3";
+		};
 	};
 };
-- 
1.7.0.4
