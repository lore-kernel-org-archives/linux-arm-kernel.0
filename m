From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:13 +0100
Subject: [PATCH 43/69] arm64: dts: renesas: r8a77965: Add "reg" properties
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <9e1b00a2ef43049617e1d3e99e258e7b2d9f98ea.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add "reg" properties to place-holder nodes with unit address defined for
R-Car M3-N SoC.

This silences the following DTC compiler warning:
Warning (unit_address_vs_reg): Node /soc/... has a unit name,
but no reg property

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 55f05f79f7f7..4286453ba92d 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -317,6 +317,7 @@
 		};
 
 		intc_ex: interrupt-controller at e61c0000 {
+			reg = <0 0xe61c0000 0 0x200>;
 			/* placeholder */
 		};
 
@@ -520,130 +521,163 @@
 		};
 
 		avb: ethernet at e6800000 {
+			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
 			/* placeholder */
 		};
 
 		csi20: csi2 at fea80000 {
+			reg = <0 0xfea80000 0 0x10000>;
 			/* placeholder */
 		};
 
 		csi40: csi2 at feaa0000 {
+			reg = <0 0xfeaa0000 0 0x10000>;
 			/* placeholder */
 		};
 
 		vin0: video at e6ef0000 {
+			reg = <0 0xe6ef0000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin1: video at e6ef1000 {
+			reg = <0 0xe6ef1000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin2: video at e6ef2000 {
+			reg = <0 0xe6ef2000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin3: video at e6ef3000 {
+			reg = <0 0xe6ef3000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin4: video at e6ef4000 {
+			reg = <0 0xe6ef4000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin5: video at e6ef5000 {
+			reg = <0 0xe6ef5000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin6: video at e6ef6000 {
+			reg = <0 0xe6ef6000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin7: video at e6ef7000 {
+			reg = <0 0xe6ef7000 0 0x1000>;
 			/* placeholder */
 		};
 
 		ohci0: usb at ee080000 {
+			reg = <0 0xee080000 0 0x100>;
 			/* placeholder */
 		};
 
 		ehci0: usb at ee080100 {
+			reg = <0 0xee080100 0 0x100>;
 			/* placeholder */
 		};
 
 		usb2_phy0: usb-phy at ee080200 {
+			reg = <0 0xee080200 0 0x700>;
 			/* placeholder */
 		};
 
 		ohci1: usb at ee0a0000 {
+			reg = <0 0xee0a0000 0 0x100>;
 			/* placeholder */
 		};
 
 		ehci1: usb at ee0a0100 {
+			reg = <0 0xee0a0100 0 0x100>;
 			/* placeholder */
 		};
 
 		i2c0: i2c at e6500000 {
+			reg = <0 0xe6500000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c1: i2c at e6508000 {
+			reg = <0 0xe6508000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c2: i2c at e6510000 {
+			reg = <0 0xe6510000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c3: i2c at e66d0000 {
+			reg = <0 0xe66d0000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c4: i2c at e66d8000 {
+			reg = <0 0xe66d8000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c5: i2c at e66e0000 {
+			reg = <0 0xe66e0000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c6: i2c at e66e8000 {
+			reg = <0 0xe66e8000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c_dvfs: i2c at e60b0000 {
+			reg = <0 0xe60b0000 0 0x425>;
 			/* placeholder */
 		};
 
 		pwm0: pwm at e6e30000 {
+			reg = <0 0xe6e30000 0 8>;
 			/* placeholder */
 		};
 
 		pwm1: pwm at e6e31000 {
+			reg = <0 0xe6e31000 0 8>;
 			/* placeholder */
 		};
 
 		pwm2: pwm at e6e32000 {
+			reg = <0 0xe6e32000 0 8>;
 			/* placeholder */
 		};
 
 		pwm3: pwm at e6e33000 {
+			reg = <0 0xe6e33000 0 8>;
 			/* placeholder */
 		};
 
 		pwm4: pwm at e6e34000 {
+			reg = <0 0xe6e34000 0 8>;
 			/* placeholder */
 		};
 
 		pwm5: pwm at e6e35000 {
+			reg = <0 0xe6e35000 0 8>;
 			/* placeholder */
 		};
 
 		pwm6: pwm at e6e36000 {
+			reg = <0 0xe6e36000 0 8>;
 			/* placeholder */
 		};
 
 		du: display at feb00000 {
+			reg = <0 0xfeb00000 0 0x80000>,
+			      <0 0xfeb90000 0 0x14>;
 			/* placeholder */
 
 			ports {
@@ -666,18 +700,26 @@
 		};
 
 		hsusb: usb at e6590000 {
+			reg = <0 0xe6590000 0 0x100>;
 			/* placeholder */
 		};
 
 		pciec0: pcie at fe000000 {
+			reg = <0 0xfe000000 0 0x80000>;
 			/* placeholder */
 		};
 
 		pciec1: pcie at ee800000 {
+			reg = <0 0xee800000 0 0x80000>;
 			/* placeholder */
 		};
 
 		rcar_sound: sound at ec500000 {
+			reg =	<0 0xec500000 0 0x1000>, /* SCU */
+				<0 0xec5a0000 0 0x100>,  /* ADG */
+				<0 0xec540000 0 0x1000>, /* SSIU */
+				<0 0xec541000 0 0x280>,  /* SSI */
+				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
 			/* placeholder */
 
 			rcar_sound,dvc {
@@ -703,38 +745,47 @@
 		};
 
 		usb2_phy1: usb-phy at ee0a0200 {
+			reg = <0 0xee0a0200 0 0x700>;
 			/* placeholder */
 		};
 
 		sdhi0: sd at ee100000 {
+			reg = <0 0xee100000 0 0x2000>;
 			/* placeholder */
 		};
 
 		sdhi1: sd at ee120000 {
+			reg = <0 0xee120000 0 0x2000>;
 			/* placeholder */
 		};
 
 		sdhi2: sd at ee140000 {
+			reg = <0 0xee140000 0 0x2000>;
 			/* placeholder */
 		};
 
 		sdhi3: sd at ee160000 {
+			reg = <0 0xee160000 0 0x2000>;
 			/* placeholder */
 		};
 
 		usb3_phy0: usb-phy at e65ee000 {
+			reg = <0 0xe65ee000 0 0x90>;
 			/* placeholder */
 		};
 
 		usb3_peri0: usb at ee020000 {
+			reg = <0 0xee020000 0 0x400>;
 			/* placeholder */
 		};
 
 		xhci0: usb at ee000000 {
+			reg = <0 0xee000000 0 0xc00>;
 			/* placeholder */
 		};
 
 		wdt0: watchdog at e6020000 {
+			reg = <0 0xe6020000 0 0x0c>;
 			/* placeholder */
 		};
 	};
-- 
2.11.0
