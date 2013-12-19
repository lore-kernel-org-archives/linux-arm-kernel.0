From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 19 Dec 2013 16:11:13 +0100
Subject: [PATCH 1/3] ARM: at91/dt: add clk properties to sama5d3 SHA device
 node
In-Reply-To: <1387465875-4548-1-git-send-email-b.brezillon@overkiz.com>
References: <1387465875-4548-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1387465875-4548-2-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/sama5d3.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index de9fece..4d290ad 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -336,6 +336,8 @@
 				compatible = "atmel,sam9g46-sha";
 				reg = <0xf8034000 0x100>;
 				interrupts = <42 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&sha_clk>;
+				clock-names = "sha_clk";
 			};
 
 			aes at f8038000 {
-- 
1.7.9.5
