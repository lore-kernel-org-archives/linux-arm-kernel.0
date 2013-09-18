From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:29 +0100
Subject: [PATCH 32/41] ARM: ux500: Remove AUXDATA relating to GPIO clock-name
 bindings
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-33-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 12eee81..a5e89af 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -228,15 +228,6 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl18x", 0x80005000, "sdi2",  &mop500_sdi2_data),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4",  &mop500_sdi4_data),
 	/* Requires clock name bindings. */
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e000, "gpio.0", NULL),
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e080, "gpio.1", NULL),
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e000, "gpio.2", NULL),
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e080, "gpio.3", NULL),
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e100, "gpio.4", NULL),
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e180, "gpio.5", NULL),
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8011e000, "gpio.6", NULL),
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8011e080, "gpio.7", NULL),
-	OF_DEV_AUXDATA("st,nomadik-gpio", 0xa03fe000, "gpio.8", NULL),
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80004000, "nmk-i2c.0", NULL),
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80122000, "nmk-i2c.1", NULL),
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80128000, "nmk-i2c.2", NULL),
-- 
1.8.1.2
