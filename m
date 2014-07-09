From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:07:01 +0200
Subject: [PATCHv3 33/34] ARM: at91/dt: tny_a9263: define crystals frequencies
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-34-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define Calao TNY-A9263 main and slow crystals frequencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>
---
 arch/arm/boot/dts/tny_a9263.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 0751a6a979a8..3043296345b7 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -29,6 +29,14 @@
 			compatible = "atmel,osc", "fixed-clock";
 			clock-frequency = <12000000>;
 		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
 	};
 
 	ahb {
-- 
1.9.1
