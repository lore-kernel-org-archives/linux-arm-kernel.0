From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 21 Feb 2014 20:48:57 +0100
Subject: [PATCHv3 8/9] ARM: at91/dt: define main clk frequency of at91sam9rlek
In-Reply-To: <1393012138-17255-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1393012138-17255-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1393012138-17255-9-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the main clock frequency for the new main clock node in
at91sam9rlek.dts

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rlek.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index 04510135f2a0..cb75b8ae07ec 100644
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
