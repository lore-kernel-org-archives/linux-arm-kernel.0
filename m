From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 29 Mar 2017 11:38:26 +0200
Subject: [PATCH 2/3] ARM: dts: alpine: add spaces before the uart node units.
In-Reply-To: <20170329093827.18881-1-antoine.tenart@free-electrons.com>
References: <20170329093827.18881-1-antoine.tenart@free-electrons.com>
Message-ID: <20170329093827.18881-2-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cosmetic cleanup to have consistent node definitions. Add a space before
the node units which do not have one.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/alpine.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 341a500c8d8a..d84bd7955b54 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -120,7 +120,7 @@
 				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		uart0:uart at fd883000 {
+		uart0: uart at fd883000 {
 			compatible = "ns16550a";
 			reg = <0x0 0xfd883000 0x0 0x1000>;
 			clock-frequency = <0>; /* Filled by loader */
@@ -129,7 +129,7 @@
 			reg-io-width = <4>;
 		};
 
-		uart1:uart at fd884000 {
+		uart1: uart at fd884000 {
 			compatible = "ns16550a";
 			reg = <0x0 0xfd884000 0x0 0x1000>;
 			clock-frequency = <0>; /* Filled by loader */
-- 
2.11.0
