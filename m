From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:33 +0300
Subject: [PATCH 04/37] ARM: imx6sx-sdb: Fix typo in regulator enable GPIO
 property
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-5-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property name should be "gpio", not "gpios". Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index ac88c3467078..94ac4005d9cd 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -114,7 +114,7 @@
 			regulator-name = "peri_3v3";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+			gpio = <&gpio4 16 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 			regulator-always-on;
 		};
-- 
2.4.9
