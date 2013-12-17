From: mporter@linaro.org (Matt Porter)
Date: Tue, 17 Dec 2013 14:42:31 -0500
Subject: [PATCH v7 4/9] usb: gadget: s3c-hsotg: add snps,
 dwc2 compatible string
In-Reply-To: <1387309356-17195-1-git-send-email-mporter@linaro.org>
References: <1387309356-17195-1-git-send-email-mporter@linaro.org>
Message-ID: <1387309356-17195-5-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the dwc2 binding.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 drivers/usb/gadget/s3c-hsotg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index db797f2..cbfbf41 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3726,6 +3726,7 @@ static int s3c_hsotg_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id s3c_hsotg_of_ids[] = {
 	{ .compatible = "samsung,s3c6400-hsotg", },
+	{ .compatible = "snps,dwc2", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s3c_hsotg_of_ids);
-- 
1.8.4
