From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Thu, 22 Jun 2017 13:44:34 +0800
Subject: [PATCH 3/3] iio: adc: mt7622: Add compatible node for mt7622.
In-Reply-To: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1498110274-18678-4-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds mt7622 compatible node.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 2dd7c74..4a2cd9e 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -308,6 +308,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
 static const struct of_device_id mt6577_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt2701-auxadc", },
 	{ .compatible = "mediatek,mt8173-auxadc", },
+	{ .compatible = "mediatek,mt7622-auxadc", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);
-- 
1.7.9.5
