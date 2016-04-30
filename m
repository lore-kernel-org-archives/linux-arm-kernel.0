From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 30 Apr 2016 23:15:37 +0200
Subject: [RFC PATCH 5/7] ARM: pxa: mioa701 remove wm9713 from platform devices
In-Reply-To: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1462050939-27940-6-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the ac97 autoprobing is introduced, remove the manually added wm9713
device.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/mioa701.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 38a96a193dc4..e69e20febf83 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -690,7 +690,6 @@ static struct platform_device *devices[] __initdata = {
 	&mioa701_gpio_keys,
 	&mioa701_backlight,
 	&mioa701_led,
-	&wm9713_acodec,
 	&pxa2xx_pcm,
 	&mioa701_sound,
 	&power_dev,
-- 
2.1.4
