From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 29 Sep 2016 20:22:06 +0200
Subject: [PATCH 2/2] ARM: dts: armada-370-rn104: drop specification of
 compatible for i2c0
In-Reply-To: <1475173326-24673-1-git-send-email-uwe@kleine-koenig.org>
References: <1475173326-24673-1-git-send-email-uwe@kleine-koenig.org>
Message-ID: <1475173326-24673-2-git-send-email-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string is already provided by armada-370.dtsi.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index d44a850d879c..14c379699350 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -126,7 +126,6 @@
 			};
 
 			i2c at 11000 {
-				compatible = "marvell,mv64xxx-i2c";
 				clock-frequency = <100000>;
 
 				pinctrl-0 = <&i2c0_pins>;
-- 
2.8.1
