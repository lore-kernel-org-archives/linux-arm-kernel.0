From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 18 Aug 2016 20:02:15 +0200
Subject: [PATCH v2 1/3] ARM: dts: sun6i: colorfly-e708-q1: Remove unused
 mma8452_int_e708_q1 node
In-Reply-To: <1471543337-6938-1-git-send-email-hdegoede@redhat.com>
References: <1471543337-6938-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471543337-6938-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The presence of the mma8452_int_e708_q1 node is a copy and paste
error, remove it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
index 9040bb9..34d8710 100644
--- a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
@@ -93,13 +93,6 @@
 };
 
 &pio {
-	mma8452_int_e708_q1: mma8452_int_pin at 0 {
-		allwinner,pins = "PA9";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-
 	mmc0_cd_pin_e708_q1: mmc0_cd_pin at 0 {
 		allwinner,pins = "PA8";
 		allwinner,function = "gpio_in";
-- 
2.7.4
