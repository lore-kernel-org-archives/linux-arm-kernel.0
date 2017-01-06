From: ahaslam@baylibre.com (Axel Haslam)
Date: Fri,  6 Jan 2017 10:40:54 +0100
Subject: [PATCH v2 2/2] ARM: dts: da850-lcdk: Enable ohci for omapl138 lcdk
In-Reply-To: <20170106094054.27767-1-ahaslam@baylibre.com>
References: <20170106094054.27767-1-ahaslam@baylibre.com>
Message-ID: <20170106094054.27767-3-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the usb1 controller (ohci) and phy for the lcdk board

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 03f9bfd..94f6ea9 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -166,6 +166,10 @@
 	status = "okay";
 };
 
+&usb1 {
+	status = "okay";
+};
+
 &aemif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_pins>;
-- 
2.9.3
