From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 6 Jan 2017 14:59:47 +0800
Subject: [PATCH 3/3] ARM: dts: at91: use "atmel,sama5d4-ddramc" for ramc
In-Reply-To: <20170106065947.30631-1-wenyou.yang@atmel.com>
References: <20170106065947.30631-1-wenyou.yang@atmel.com>
Message-ID: <20170106065947.30631-4-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new compatible "atmel,sama5d4-ddramc" for the ramc of
SAMA5D2 and SAMA5D4.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ceb9783ff7e1..b5259d85737d 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -380,7 +380,7 @@
 			};
 
 			ramc0: ramc at f000c000 {
-				compatible = "atmel,sama5d3-ddramc";
+				compatible = "atmel,sama5d4-ddramc";
 				reg = <0xf000c000 0x200>;
 				clocks = <&ddrck>, <&mpddr_clk>;
 				clock-names = "ddrck", "mpddr";
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 4f60c1b7b137..603ba986858c 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -370,7 +370,7 @@
 			};
 
 			ramc0: ramc at f0010000 {
-				compatible = "atmel,sama5d3-ddramc";
+				compatible = "atmel,sama5d4-ddramc";
 				reg = <0xf0010000 0x200>;
 				clocks = <&ddrck>, <&mpddr_clk>;
 				clock-names = "ddrck", "mpddr";
-- 
2.11.0
