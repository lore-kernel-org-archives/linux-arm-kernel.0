From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Jan 2013 11:10:24 +0900
Subject: [PATCH] ARM: mach-shmobile: emev2: Add reg and device_type properties
 to cpus
Message-ID: <1359425424-30337-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index eb504a6..2b6d1c0 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -16,10 +16,14 @@
 
 	cpus {
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
