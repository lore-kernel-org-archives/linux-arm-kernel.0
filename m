From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 16 Nov 2010 18:14:53 +0800
Subject: [PATCH TRIVIAL] AT91: usb: fix typo in atmel_usba_udc driver
Message-ID: <1289902493-1821-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
fix against 2.6.37-rc1

 drivers/usb/gadget/atmel_usba_udc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index b5e20e8..717ff65 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -2017,7 +2017,7 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 			}
 		} else {
 			/* gpio_request fail so use -EINVAL for gpio_is_valid */
-			ubc->vbus_pin = -EINVAL;
+			udc->vbus_pin = -EINVAL;
 		}
 	}
 
-- 
1.6.3.3
