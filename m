From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 19 Dec 2013 16:11:15 +0100
Subject: [PATCH 3/3] ARM: at91/dt: add clk properties to sama5d3 TDES device
 node
In-Reply-To: <1387465875-4548-1-git-send-email-b.brezillon@overkiz.com>
References: <1387465875-4548-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1387465875-4548-4-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/sama5d3.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index ae0c5b3..e398e5d 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -352,6 +352,8 @@
 				compatible = "atmel,sam9g46-tdes";
 				reg = <0xf803c000 0x100>;
 				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&tdes_clk>;
+				clock-names = "tdes_clk";
 			};
 
 			dma0: dma-controller at ffffe600 {
-- 
1.7.9.5
