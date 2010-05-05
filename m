From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 00:13:26 +0200
Subject: [PATCH 3/9] Add RTC platform device for Acer n30 / Acer n35
In-Reply-To: <4BE1ED3E.1050201@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz> <4BE1ED3E.1050201@vscht.cz>
Message-ID: <4BE1ED86.3010506@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 1b635fd..ce1172e 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -323,6 +323,7 @@ static struct platform_device *n30_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_iis,
 	&s3c_device_ohci,
+	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&n30_button_device,
 	&n30_blue_led,
@@ -334,6 +335,7 @@ static struct platform_device *n35_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_iis,
+	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&n35_button_device,
 };
-- 
1.7.1
