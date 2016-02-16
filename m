From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 16 Feb 2016 10:30:54 +0530
Subject: [PATCH v3 2/3] ARM: dts: Change iio_hwmon nodes to use hypen in node
 names
In-Reply-To: <cover.1455597464.git.maitysanchayan@gmail.com>
References: <cover.1455597464.git.maitysanchayan@gmail.com>
Message-ID: <c47b13603fe72737ef67ed8b90fc61516cfa2a20.1455597464.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change iio_hwmon nodes to use hypen in node names instead of
underscore.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 Documentation/devicetree/bindings/iio/iio-bindings.txt | 2 +-
 arch/arm/boot/dts/imx23.dtsi                           | 2 +-
 arch/arm/boot/dts/imx28.dtsi                           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index 0b447d9..68d6f8c 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -82,7 +82,7 @@ vdd channel is connected to output 0 of the &ref device.
 
 	...
 
-	iio_hwmon {
+	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
 			<&adc 3>, <&adc 4>, <&adc 5>,
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 1c6c075..302d116 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -569,7 +569,7 @@
 		};
 	};
 
-	iio_hwmon {
+	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&lradc 8>;
 	};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index fae7b90..f637ec9 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1256,7 +1256,7 @@
 		};
 	};
 
-	iio_hwmon {
+	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&lradc 8>;
 	};
-- 
2.7.1
