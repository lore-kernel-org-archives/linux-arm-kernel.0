From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 21:36:57 +0900
Subject: [PATCH v2 3/8] ARM: dts: tps65217: Add the power button device
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Message-ID: <20161028123702.21849-4-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the power button driver and disable it by default.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 8f77d0d..02de56b 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -21,6 +21,11 @@
 		status = "disabled";
 	};
 
+	pwrbutton {
+		compatible = "ti,tps65217-pwrbutton";
+		status = "disabled";
+	};
+
 	regulators {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.9.3
