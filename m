From: sourav.poddar@ti.com (Sourav Poddar)
Date: Tue, 14 Aug 2012 21:54:30 +0530
Subject: [PATCHv3 1/4] arm/dts: omap5-evm: Add I2C support
In-Reply-To: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
References: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <1344961473-13675-2-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C data node in omap5 device tree file.

Tested on omap5430 evm.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 57e5270..6b68dfe 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -145,6 +145,41 @@
 			#interrupt-cells = <1>;
 		};
 
+		i2c1: i2c at 48070000 {
+			compatible = "ti,omap4-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c1";
+		};
+
+		i2c2: i2c at 48072000 {
+			compatible = "ti,omap4-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c2";
+		};
+
+		i2c3: i2c at 48060000 {
+			compatible = "ti,omap4-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c3";
+		};
+
+		i2c4: i2c at 4807A000 {
+			compatible = "ti,omap4-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c4";
+		};
+
+		i2c5: i2c at 4807C000 {
+			compatible = "ti,omap4-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c5";
+		};
+
 		uart1: serial at 4806a000 {
 			compatible = "ti,omap4-uart";
 			ti,hwmods = "uart1";
-- 
1.7.1
