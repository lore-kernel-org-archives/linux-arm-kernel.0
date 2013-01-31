From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:26:06 +0900
Subject: [PATCH 1/4] ARM: mach-shmobile: sh73a0: Add reg and device_type
 properties to cpus
In-Reply-To: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613569-26981-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 721f486..8a59465 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -14,11 +14,18 @@
 	compatible = "renesas,sh73a0";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			reg = <0>;
 		};
 		cpu at 1 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			reg = <1>;
 		};
 	};
 
-- 
1.7.10.4
