From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 18:44:03 +0200
Subject: [PATCH 1/2] ARM: dts: sunxi: cpus/cpu nodes dts updates
In-Reply-To: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1372437844-16325-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 2 ++
 arch/arm/boot/dts/sun5i-a13.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 9e6fb45..676c704 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -17,7 +17,9 @@
 
 	cpus {
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a8";
+			reg = <0x0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index df96c54..ee1f31f 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -18,7 +18,9 @@
 
 	cpus {
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a8";
+			reg = <0x0>;
 		};
 	};
 
-- 
1.8.3.1
