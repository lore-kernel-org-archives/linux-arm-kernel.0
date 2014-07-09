From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:06:34 +0200
Subject: [PATCHv3 06/34] ARM: at91/dt: at91rm9200ek: define crystals
 frequencies
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91rm9200ek main and slow crystals frequencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200ek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index df6b0aa0e4dd..43eb779dd6f6 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -25,6 +25,14 @@
 			compatible = "atmel,osc", "fixed-clock";
 			clock-frequency = <18432000>;
 		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <18432000>;
+		};
 	};
 
 	ahb {
-- 
1.9.1
