From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  7 Jul 2014 22:23:41 +0200
Subject: [PATCHv2 24/32] ARM: at91/dt: sam9m10g45ek: define crystals
 frequencies
In-Reply-To: <1404764629-29136-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404764629-29136-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404764629-29136-25-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91sam9m10g45ek main and slow crystals frequencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 9f5b0a674995..96ccc7de4f0a 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -31,6 +31,14 @@
 			compatible = "atmel,osc", "fixed-clock";
 			clock-frequency = <12000000>;
 		};
+
+		slow_xtal {
+		      clock-frequency = <32768>;
+		};
+
+		main_xtal {
+		      clock-frequency = <12000000>;
+		};
 	};
 
 	ahb {
-- 
1.9.1
