From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  1 Jul 2014 16:12:23 +0200
Subject: [PATCH 14/33] ARM: at91/dt: usb_a9260: define crystals frequencies
In-Reply-To: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404223962-30471-15-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define Calao USB-A9260, USB-A9G20 and USB-A9G20-LPW main and slow crystals
frequencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>
---
 arch/arm/boot/dts/usb_a9260_common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index 285977682cf3..12edafefd44a 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -16,6 +16,14 @@
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
