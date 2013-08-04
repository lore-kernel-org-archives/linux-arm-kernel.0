From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 11:34:01 +0200
Subject: [PATCH 3/6] ARM: sun5i: a10s: Remove useless simple-bus reg property
In-Reply-To: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375608844-13159-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reg property of the simple-bus driver is completely useless. Remove
it from the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 0f0881a..ec6c2b6 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -161,7 +161,6 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x01c20000 0x300000>;
 		ranges;
 
 		emac: ethernet at 01c0b000 {
-- 
1.8.3.4
