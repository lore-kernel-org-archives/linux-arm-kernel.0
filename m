From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 Apr 2013 18:28:21 +0100
Subject: [RFC PATCH v3 16/17] ARM: dts: sunxi: cpus/cpu nodes dts updates
In-Reply-To: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366824502-19729-17-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/sunxi.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 8b36abe..9f45ecf 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -17,8 +17,13 @@
 	interrupt-parent = <&intc>;
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
+			device_type = "cpu";
+			reg = <0x0>;
 		};
 	};
 
-- 
1.7.12
