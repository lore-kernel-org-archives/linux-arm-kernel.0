From: josh.wu@atmel.com (Josh Wu)
Date: Sun, 4 Jan 2015 17:02:26 +0800
Subject: [PATCH v2 1/8] ARM: at91: dts: sama5d3: add isi clock
In-Reply-To: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
References: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1420362153-500-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ISI peripheral clock in sama5d3.dtsi.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5f4144d..61746ef 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -214,6 +214,8 @@
 				compatible = "atmel,at91sam9g45-isi";
 				reg = <0xf0034000 0x4000>;
 				interrupts = <37 IRQ_TYPE_LEVEL_HIGH 5>;
+				clocks = <&isi_clk>;
+				clock-names = "isi_clk";
 				status = "disabled";
 			};
 
-- 
1.9.1
