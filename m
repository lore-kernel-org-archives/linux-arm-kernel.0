From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:56 +0100
Subject: [RFC PATCH v4 13/18] ARM: dts: pxa2xx: cpus/cpu nodes dts updates
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-14-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index f18aad3..a5e90f0 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -23,8 +23,11 @@
 	};
 
 	cpus {
-		cpu at 0 {
-			compatible = "arm,xscale";
+		#address-cells = <0>;
+		#size-cells = <0>;
+		cpu {
+			compatible = "marvell,xscale";
+			device_type = "cpu";
 		};
 	};
 
-- 
1.8.2.2
