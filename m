From: joel@jms.id.au (Joel Stanley)
Date: Mon, 11 Dec 2017 15:36:47 +1030
Subject: [PATCH 03/20] ARM: dts: aspeed-g4: Correct VUART IRQ number
In-Reply-To: <20171211050704.20621-1-joel@jms.id.au>
References: <20171211050704.20621-1-joel@jms.id.au>
Message-ID: <20171211050704.20621-4-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should have always been 8.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 100d092e6c07..9ebf90f34709 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -220,7 +220,7 @@
 				compatible = "aspeed,ast2400-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
-				interrupts = <10>;
+				interrupts = <8>;
 				clocks = <&clk_uart>;
 				no-loopback-test;
 				status = "disabled";
-- 
2.14.1
