From: manabian@gmail.com (Joachim Eastwood)
Date: Tue,  4 Dec 2012 19:10:56 +0100
Subject: [PATCH 1/4] ARM: at91: fix gpios on i2c-gpio for RM9200 DT
In-Reply-To: <1354644659-31385-1-git-send-email-manabian@gmail.com>
References: <1354644659-31385-1-git-send-email-manabian@gmail.com>
Message-ID: <1354644659-31385-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
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
