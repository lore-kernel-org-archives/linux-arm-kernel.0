From: mporter@linaro.org (Matt Porter)
Date: Fri, 13 Dec 2013 11:51:18 -0500
Subject: [PATCH v6 4/9] usb: gadget: s3c-hsotg: add snps,
 dwc2 compatible string
In-Reply-To: <1386953483-21631-1-git-send-email-mporter@linaro.org>
References: <1386953483-21631-1-git-send-email-mporter@linaro.org>
Message-ID: <1386953483-21631-5-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the dwc2 binding.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 drivers/usb/gadget/s3c-hsotg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 8ceb5ef..7c5d8bd 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3727,6 +3727,7 @@ static int s3c_hsotg_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id s3c_hsotg_of_ids[] = {
 	{ .compatible = "samsung,s3c6400-hsotg", },
+	{ .compatible = "snps,dwc2", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s3c_hsotg_of_ids);
-- 
1.8.4
