From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 19 Nov 2013 15:45:46 +0100
Subject: [PATCH v3 7/8] ARM: shmobile: r8a7790: Reference clocks
In-Reply-To: <1384872347-11724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384872347-11724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1384872347-11724-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference clocks using a "clocks" property in all nodes corresponding to
devices that require a clock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e3c6072..fe65a68 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -190,6 +190,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C0>;
 		status = "disabled";
 	};
 
@@ -200,6 +201,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C1>;
 		status = "disabled";
 	};
 
@@ -210,6 +212,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C2>;
 		status = "disabled";
 	};
 
@@ -220,6 +223,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_I2C3>;
 		status = "disabled";
 	};
 
@@ -228,6 +232,7 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -237,6 +242,7 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -251,6 +257,7 @@
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -260,6 +267,7 @@
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -269,6 +277,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -278,6 +287,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
-- 
1.8.3.2
