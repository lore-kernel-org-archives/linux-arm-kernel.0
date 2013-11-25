From: matt.porter@linaro.org (Matt Porter)
Date: Mon, 25 Nov 2013 13:16:02 -0500
Subject: [PATCH v3 4/9] usb: gadget: s3c-hsotg: add snps,
 dwc2 compatible string
In-Reply-To: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
References: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1385403367-18144-5-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the dwc2 binding.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 drivers/usb/gadget/s3c-hsotg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index a8e6c3d..da3879b 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3728,6 +3728,7 @@ static int s3c_hsotg_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id s3c_hsotg_of_ids[] = {
 	{ .compatible = "samsung,s3c6400-hsotg", },
+	{ .compatible = "snps,dwc2", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s3c_hsotg_of_ids);
-- 
1.8.4
