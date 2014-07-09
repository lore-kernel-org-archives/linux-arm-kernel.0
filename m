From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:06:45 +0200
Subject: [PATCHv3 17/34] ARM: at91/dt: ge863-pro3: define main crystal
 frequency
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-18-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define Telit GE863-PRO3 main crystal frequency.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/ge863-pro3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/ge863-pro3.dtsi
index 230099bb31c8..0d0e62489d93 100644
--- a/arch/arm/boot/dts/ge863-pro3.dtsi
+++ b/arch/arm/boot/dts/ge863-pro3.dtsi
@@ -19,6 +19,10 @@
 			compatible = "atmel,osc", "fixed-clock";
 			clock-frequency = <6000000>;
 		};
+
+		main_xtal {
+			clock-frequency = <6000000>;
+		};
 	};
 
 	ahb {
-- 
1.9.1
