From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 15 Feb 2012 18:37:36 +0100
Subject: [PATCH 3/4] arm/dts: OMAP3: Add SPI controller nodes
In-Reply-To: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
References: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
Message-ID: <1329327457-2121-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 4 McSPI controller nodes present in an OMAP3 device.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap3.dtsi |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 8eb181e..97079fe 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -167,5 +167,37 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
+
+		mcspi1: mcspi at 1 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+		};
+
+		mcspi2: mcspi at 2 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi3: mcspi at 3 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi4: mcspi at 4 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi4";
+			ti,spi-num-cs = <1>;
+		};
 	};
 };
-- 
1.7.0.4
