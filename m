From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 Apr 2013 16:27:24 +0100
Subject: [RFC PATCH v2 02/13] ARM: mach-mv78xx0: cpus/cpu node dts updates
In-Reply-To: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366644455-16550-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 6f1acc7..79a6689 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -24,6 +24,7 @@
 
 	cpus {
 		cpu at 0 {
+			reg = <0>;
 			compatible = "marvell,sheeva-v7";
 		};
 	};
-- 
1.7.12
