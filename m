From: andrew-sh.cheng@mediatek.com (Andrew-sh Cheng)
Date: Fri, 8 Dec 2017 14:07:55 +0800
Subject: [PATCH v1 1/4] cpufreq: mediatek: add mt2712 into compatible list
In-Reply-To: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
Message-ID: <1512713278-17807-2-git-send-email-andrew-sh.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support mt2712 in mediatek-cpufreq.c

Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 18c4bd9..62aec5c 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -574,6 +574,7 @@ static struct platform_driver mtk_cpufreq_platdrv = {
 /* List of machines supported by this driver */
 static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", },
+	{ .compatible = "mediatek,mt2712", },
 	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
 	{ .compatible = "mediatek,mt817x", },
-- 
2.6.4
