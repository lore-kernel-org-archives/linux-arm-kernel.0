From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 12 Mar 2014 10:43:44 +0100
Subject: [PATCHv5 8/9] ARM: at91/dt: define main clk frequency of at91sam9rlek
In-Reply-To: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394617425-641-9-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the main clock frequency for the new main clock node in
at91sam9rlek.dts

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rlek.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index c3cec5d07648..cddb37825fad 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -105,6 +105,12 @@
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
