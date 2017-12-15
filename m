From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:29 +1030
Subject: [PATCH v2 05/19] ARM: dts: aspeed: Add MAC clocks
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-6-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c87883a7f250..cf407b4db630 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -91,6 +91,7 @@
 			compatible = "aspeed,ast2400-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
 			interrupts = <2>;
+			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
 			status = "disabled";
 		};
 
@@ -98,6 +99,7 @@
 			compatible = "aspeed,ast2400-mac", "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
 			interrupts = <3>;
+			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 90bc09d93ea6..ab26156d6822 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -125,6 +125,7 @@
 			compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
 			interrupts = <2>;
+			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
 			status = "disabled";
 		};
 
@@ -132,6 +133,7 @@
 			compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
 			interrupts = <3>;
+			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
 			status = "disabled";
 		};
 
-- 
2.14.1
