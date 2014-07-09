From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:06:55 +0200
Subject: [PATCHv3 27/34] ARM: at91/dt: pm9g45: crystals frequencies
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-28-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define Ronetix pm9g45 main and slow crystals frequencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/pm9g45.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index 33ffabe9c4c8..66afcff67fde 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -29,6 +29,14 @@
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
