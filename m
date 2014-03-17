From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 17 Mar 2014 14:57:08 +0100
Subject: [PATCH v2 15/15] ARM: at91/dt: at91-cosino_mega2560 remove useless
 tsadcc node
In-Reply-To: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1395064628-644-16-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tsadcc node is useless as it doesn't refer to anything and the touchscreen
is handled by the adc0 node.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rodolfo Giometti <giometti@linux.it>
---
 arch/arm/boot/dts/at91-cosino_mega2560.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91-cosino_mega2560.dts b/arch/arm/boot/dts/at91-cosino_mega2560.dts
index f9415dd11f17..cce621239b72 100644
--- a/arch/arm/boot/dts/at91-cosino_mega2560.dts
+++ b/arch/arm/boot/dts/at91-cosino_mega2560.dts
@@ -33,11 +33,6 @@
 				status = "okay";
 			};
 
-
-			tsadcc: tsadcc at f804c000 {
-				status = "okay";
-			};
-
 			rtc at fffffeb0 {
 				status = "okay";
 			};
-- 
1.8.3.2
