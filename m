From: mhei@heimpold.de (Michael Heimpold)
Date: Wed, 26 Mar 2014 23:35:04 +0100
Subject: [PATCH 3/3] arm: mxs: dt: imx28-duckbill: use symbolic names from
 gpio.h
In-Reply-To: <1395873319-28286-1-git-send-email-mhei@heimpold.de>
References: <1395873319-28286-1-git-send-email-mhei@heimpold.de>
Message-ID: <1395873319-28286-4-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW instead of 0 and 1.

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/imx28-duckbill.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index 91c1a9a..ce1a7ef 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -110,12 +110,12 @@
 
 		status {
 			label = "duckbill:green:status";
-			gpios = <&gpio3 5 0>;
+			gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
 		};
 
 		failure {
 			label = "duckbill:red:status";
-			gpios = <&gpio3 4 0>;
+			gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
-- 
1.7.10.4
