From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 16 May 2017 15:59:00 +0800
Subject: [PATCH] arm: aspeed: Use 'ast2500' compatible strings where
 appropriate
Message-ID: <20170516075900.23202-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index a0bea4a6ec77..48a092e735d9 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -88,7 +88,7 @@
 		};
 
 		vic: interrupt-controller at 1e6c0080 {
-			compatible = "aspeed,ast2400-vic";
+			compatible = "aspeed,ast2500-vic";
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			valid-sources = <0xfefff7ff 0x0807ffff>;
@@ -993,7 +993,7 @@
 			};
 
 			timer: timer at 1e782000 {
-				compatible = "aspeed,ast2400-timer";
+				compatible = "aspeed,ast2500-timer";
 				reg = <0x1e782000 0x90>;
 				// The moxart_timer driver registers only one
 				// interrupt and assumes it's for timer 1
-- 
2.9.3
