From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 21 Oct 2016 23:01:02 +0900
Subject: [PATCH 3/7] ARM: dts: tps65217: Add the power button device
In-Reply-To: <20161021140106.21531-1-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
Message-ID: <20161021140106.21531-4-woogyom.kim@gmail.com>
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
