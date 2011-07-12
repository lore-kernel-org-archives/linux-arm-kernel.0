From: axel.lin@gmail.com (Axel Lin)
Date: Tue, 12 Jul 2011 19:05:29 +0800
Subject: [PATCH] USB: s3c2410_udc: fix unterminated platform_device_id table
Message-ID: <1310468729.6590.3.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/usb/gadget/s3c2410_udc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index 85c1b0d..8d31848 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -2060,6 +2060,7 @@ static int s3c2410_udc_resume(struct platform_device *pdev)
 static const struct platform_device_id s3c_udc_ids[] = {
 	{ "s3c2410-usbgadget", },
 	{ "s3c2440-usbgadget", },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, s3c_udc_ids);
 
-- 
1.7.4.1
