From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:31 +0100
Subject: [PATCH v3 21/25] ARM: dts: s500: Set CPU enable-method
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-22-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a custom S500 enable-method for all CPUs.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: new
 
 arch/arm/boot/dts/s500.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/s500.dtsi b/arch/arm/boot/dts/s500.dtsi
index 1973181..b4ebd27 100644
--- a/arch/arm/boot/dts/s500.dtsi
+++ b/arch/arm/boot/dts/s500.dtsi
@@ -22,24 +22,28 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x0>;
+			enable-method = "actions,s500-smp";
 		};
 
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x1>;
+			enable-method = "actions,s500-smp";
 		};
 
 		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x2>;
+			enable-method = "actions,s500-smp";
 		};
 
 		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x3>;
+			enable-method = "actions,s500-smp";
 		};
 	};
 
-- 
2.10.2
