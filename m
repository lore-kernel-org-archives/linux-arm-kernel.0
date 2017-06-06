From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:19 +0200
Subject: [PATCH v4 21/28] ARM: dts: s500: Set CPU enable-method
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-22-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a custom S500 enable-method for all CPUs.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v3: new
 
 arch/arm/boot/dts/s500.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/s500.dtsi b/arch/arm/boot/dts/s500.dtsi
index fc9f71a4106a..6d6024027ee2 100644
--- a/arch/arm/boot/dts/s500.dtsi
+++ b/arch/arm/boot/dts/s500.dtsi
@@ -28,24 +28,28 @@
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
2.12.3
