From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 Apr 2013 16:27:34 +0100
Subject: [RFC PATCH v2 12/13] ARM: mach-vt8500: cpus/cpu nodes dts updates
In-Reply-To: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366644455-16550-13-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/wm8505.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index e74a1c0..a470808 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -13,7 +13,7 @@
 
 	cpus {
 		cpu at 0 {
-			compatible = "arm,arm926ejs";
+			compatible = "arm,arm926";
 		};
 	};
 
-- 
1.7.12
