From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon,  8 Oct 2012 02:10:54 +0900
Subject: [PATCH v2 4/5] ARM: dts: list the clock providers for serial ports
In-Reply-To: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
References: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1349629855-4962-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the list of clock providers in the serial port device nodes.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 1c923d3..eb1cdda 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -98,6 +98,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
 		interrupts = <0 52 0>;
+		clocks = <&uart0>, <&sclk_uart0>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -105,6 +107,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13810000 0x100>;
 		interrupts = <0 53 0>;
+		clocks = <&uart1>, <&sclk_uart1>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -112,6 +116,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13820000 0x100>;
 		interrupts = <0 54 0>;
+		clocks = <&uart2>, <&sclk_uart2>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -119,6 +125,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13830000 0x100>;
 		interrupts = <0 55 0>;
+		clocks = <&uart3>, <&sclk_uart3>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
-- 
1.7.5.4
