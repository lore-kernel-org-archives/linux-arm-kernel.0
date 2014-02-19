From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Feb 2014 16:32:30 +0100
Subject: [PATCHv2 7/8] ARM: at91/dt: define main clk frequency of at91sam9rlek
In-Reply-To: <1392823951-26053-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1392823951-26053-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1392823951-26053-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the main clock frequency for the new main clock node in
at91sam9rlek.dts

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rlek.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index aa76b1d7285a..813ca76a19cd 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -68,6 +68,12 @@
 				};
 			};
 
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <12000000>;
+				};
+			};
+
 			watchdog at fffffd40 {
 				status = "okay";
 			};
-- 
1.8.3.2
