From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  3 Apr 2012 09:32:53 +0200
Subject: [PATCH v2 09/13] ARM: at91/at91sam9x5.dtsi: fix NAND ale/cle in DT
 file
In-Reply-To: <cover.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <d3c59c197708868a4f56456122de9744c0fb72ab.1333437885.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index c111001..6597177 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -201,8 +201,8 @@
 			      >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
-			gpios = <&pioC 8 0
-				 &pioC 14 0
+			gpios = <&pioD 5 0
+				 &pioD 4 0
 				 0
 				>;
 			status = "disabled";
-- 
1.7.9.4
