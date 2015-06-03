From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  3 Jun 2015 14:24:15 +0200
Subject: [PATCH v2 13/16] ARM: at91/dt: sama5d3 xplained: use stdout-path
In-Reply-To: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1433334258-14741-14-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the bootargs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 4799e88cdf5e..d81474e0bcd6 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -14,7 +14,7 @@
 	compatible = "atmel,sama5d3-xplained", "atmel,sama5d3", "atmel,sama5";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.4
