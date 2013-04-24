From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 Apr 2013 18:28:09 +0100
Subject: [RFC PATCH v3 04/17] ARM: dts: armada-370-xp: cpus/cpu node dts
 updates
In-Reply-To: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366824502-19729-5-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 6f1acc7..f13b47a 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -23,8 +23,12 @@
 	compatible = "marvell,armada-370-xp";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		cpu at 0 {
 			compatible = "marvell,sheeva-v7";
+			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
-- 
1.7.12
