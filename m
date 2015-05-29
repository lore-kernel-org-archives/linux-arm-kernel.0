From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:15 +0200
Subject: [PATCH 02/16] ARM: at91/dt: at91sam9rlek: add RTC
In-Reply-To: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432921649-21943-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTC support to the at91sam9rlek.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rlek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index d9299be3dfe9..724b9f54a60a 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -184,6 +184,10 @@
 			watchdog at fffffd40 {
 				status = "okay";
 			};
+
+			rtc at fffffe00 {
+				status = "okay";
+			};
 		};
 	};
 
-- 
2.1.4
