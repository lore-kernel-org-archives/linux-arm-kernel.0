From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:52 +0100
Subject: [RFC PATCH v4 09/18] ARM: dts: lpc32xx: cpus/cpu nodes dts updates
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-10-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 1582f48..3abebb7 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -18,8 +18,12 @@
 	interrupt-parent = <&mic>;
 
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
 		};
 	};
 
-- 
1.8.2.2
