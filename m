From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:06:47 +0200
Subject: [PATCHv3 19/34] ARM: at91/dt: evk-pro3: define slow crytal frequency
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-20-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define Telit EVK-PRO3 slow crystal frequency

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/evk-pro3.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index 4d829685fdfb..f72969efe6d7 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -15,6 +15,12 @@
 	model = "Telit EVK-PRO3 for Telit GE863-PRO3";
 	compatible = "telit,evk-pro3", "atmel,at91sam9260", "atmel,at91sam9";
 
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+	};
+
 	ahb {
 		apb {
 			macb0: ethernet at fffc4000 {
-- 
1.9.1
