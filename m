From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:40 +0800
Subject: [PATCH v4 04/16] arm64: dts: Add Hi6220 gpio configuration nodes
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-5-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhong Kaihua <zhongkaihua@huawei.com>

Add Hi6220 gpio configuration nodes

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Kong Xinwei <kong.kongxinwei@hisilicon.com>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 239 ++++++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index dc7f21a..493bbb0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -251,5 +251,244 @@
 				 <&ao_ctrl HI6220_TIMER0_PCLK>;
 			clock-names = "timer1", "timer2", "apb_pclk";
 		};
+
+		gpio0: gpio at f8011000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8011000 0x0 0x1000>;
+			interrupts = <0 52 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio1: gpio at f8012000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8012000 0x0 0x1000>;
+			interrupts = <0 53 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio2: gpio at f8013000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8013000 0x0 0x1000>;
+			interrupts = <0 54 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio3: gpio at f8014000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8014000 0x0 0x1000>;
+			interrupts = <0 55 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio4: gpio at f7020000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7020000 0x0 0x1000>;
+			interrupts = <0 56 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio5: gpio at f7021000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7021000 0x0 0x1000>;
+			interrupts = <0 57 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio6: gpio at f7022000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7022000 0x0 0x1000>;
+			interrupts = <0 58 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio7: gpio at f7023000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7023000 0x0 0x1000>;
+			interrupts = <0 59 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio8: gpio at f7024000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7024000 0x0 0x1000>;
+			interrupts = <0 60 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio9: gpio at f7025000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7025000 0x0 0x1000>;
+			interrupts = <0 61 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio10: gpio at f7026000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7026000 0x0 0x1000>;
+			interrupts = <0 62 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio11: gpio at f7027000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7027000 0x0 0x1000>;
+			interrupts = <0 63 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio12: gpio at f7028000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7028000 0x0 0x1000>;
+			interrupts = <0 64 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio13: gpio at f7029000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7029000 0x0 0x1000>;
+			interrupts = <0 65 0x4>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio14: gpio at f702a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702a000 0x0 0x1000>;
+			interrupts = <0 66 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio15: gpio at f702b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702b000 0x0 0x1000>;
+			interrupts = <0 67 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio16: gpio at f702c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702c000 0x0 0x1000>;
+			interrupts = <0 68 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio17: gpio at f702d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702d000 0x0 0x1000>;
+			interrupts = <0 69 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio18: gpio at f702e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702e000 0x0 0x1000>;
+			interrupts = <0 70 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio19: gpio at f702f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702f000 0x0 0x1000>;
+			interrupts = <0 71 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+		};
 	};
 };
-- 
1.9.1
