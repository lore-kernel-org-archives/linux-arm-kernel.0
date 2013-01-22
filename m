From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Jan 2013 18:50:44 +0100
Subject: [PATCH 4/6] ARM: at91: fix gpios on i2c-gpio for RM9200 DT
In-Reply-To: <cover.1358876553.git.nicolas.ferre@atmel.com>
References: <cover.1358876553.git.nicolas.ferre@atmel.com>
Message-ID: <dd3ef494b69eac0a9dba9f88a22126bb7cf05066.1358876553.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
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
