From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri,  1 Dec 2017 13:07:07 +0100
Subject: [PATCH 2/3] arm: dts: mt7623: Update ethsys binding
In-Reply-To: <20171201120708.30129-1-matthias.bgg@gmail.com>
References: <20171201120708.30129-1-matthias.bgg@gmail.com>
Message-ID: <20171201120708.30129-2-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethsys binding misses the reset-cells, this patch
adds this property.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 343d3b1a4448..b750da5362f7 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -758,6 +758,7 @@
 			     "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	eth: ethernet at 1b100000 {
-- 
2.12.3
