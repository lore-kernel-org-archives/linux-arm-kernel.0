From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 29 Mar 2017 11:38:25 +0200
Subject: [PATCH 1/3] ARM: dts: alpine: remove 0x's from the uart1 node unit
 address
Message-ID: <20170329093827.18881-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove 0x's from the uart1 node unit address to have consistent nodes.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/alpine.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index f09f9c8e178a..341a500c8d8a 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -129,7 +129,7 @@
 			reg-io-width = <4>;
 		};
 
-		uart1:uart at 0xfd884000 {
+		uart1:uart at fd884000 {
 			compatible = "ns16550a";
 			reg = <0x0 0xfd884000 0x0 0x1000>;
 			clock-frequency = <0>; /* Filled by loader */
-- 
2.11.0
