From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  1 Jul 2014 16:12:21 +0200
Subject: [PATCH 12/33] ARM: at91/dt: at91sam9g20ek: define crystals frequencies
In-Reply-To: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404223962-30471-13-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91sam9g20ek main and slow crystals frequencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index cb2c010e08e2..d2919108e92d 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -26,6 +26,14 @@
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
