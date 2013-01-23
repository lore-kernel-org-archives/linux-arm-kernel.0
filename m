From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Jan 2013 10:48:51 +0100
Subject: [PATCH 4/9] ARM: at91: fix gpios on i2c-gpio for RM9200 DT
In-Reply-To: <cover.1358934163.git.nicolas.ferre@atmel.com>
References: <cover.1358934163.git.nicolas.ferre@atmel.com>
Message-ID: <334c9e8d6d05be132792a855dcc637773d44cad3.1358934163.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index e154f24..222047f 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -336,8 +336,8 @@
 
 	i2c at 0 {
 		compatible = "i2c-gpio";
-		gpios = <&pioA 23 0 /* sda */
-			 &pioA 24 0 /* scl */
+		gpios = <&pioA 25 0 /* sda */
+			 &pioA 26 0 /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
-- 
1.8.0
