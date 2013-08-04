From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 11:34:03 +0200
Subject: [PATCH 5/6] ARM: sun5i: a13: Remove useless simple-bus reg property
In-Reply-To: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375608844-13159-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reg property of the simple-bus driver is completely useless. Remove
it from the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 7363211..9d5ad20 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -154,7 +154,6 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x01c20000 0x300000>;
 		ranges;
 
 		intc: interrupt-controller at 01c20400 {
-- 
1.8.3.4
