From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Oct 2013 15:21:04 -0500
Subject: [PATCH V2 2/2] ARM: dts: AM33xx+: Add i2c aliases
In-Reply-To: <1381954864-24410-1-git-send-email-nm@ti.com>
References: <525E8D91.5090400@ti.com>
 <1381954864-24410-1-git-send-email-nm@ti.com>
Message-ID: <1381954864-24410-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide alias to allow ordering the i2c devices correctly.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    3 +++
 arch/arm/boot/dts/am4372.dtsi |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 09f16a0..defc0d5 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -18,6 +18,9 @@
 	interrupt-parent = <&intc>;
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 4944b1a..c7c3160 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -18,6 +18,9 @@
 
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
 		serial0 = &uart0;
 	};
 
-- 
1.7.9.5
