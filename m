From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:07:00 +0200
Subject: [PATCHv3 32/34] ARM: at91/dt: sam9263ek: define crystals frequencies
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-33-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91sam9263ek main and slow crystals frequencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 15009c9f2293..5cf93eecd8f1 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -29,6 +29,14 @@
 			compatible = "atmel,osc", "fixed-clock";
 			clock-frequency = <16367660>;
 		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <16367660>;
+		};
 	};
 
 	ahb {
-- 
1.9.1
