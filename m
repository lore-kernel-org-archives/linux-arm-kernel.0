From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:57 +0100
Subject: [RFC PATCH v4 14/18] ARM: dts: r8a7740: cpus/cpu nodes dts updates
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-15-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 798fa35..8a831e9 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -14,8 +14,12 @@
 	compatible = "renesas,r8a7740";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0x0>;
 		};
 	};
 };
-- 
1.8.2.2
