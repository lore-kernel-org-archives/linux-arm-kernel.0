From: dja@axtens.net (Daniel Axtens)
Date: Sat,  2 Dec 2017 23:53:37 +1100
Subject: [PATCH] [media] vcodec: mediatek: Add MODULE_LICENSE to
 mtk_vcodec_util.c
Message-ID: <20171202125337.31222-1-dja@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following warning in an allmodconfig build:
WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o

This matches the license at the top of the file.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
index 46768c056193..572efbbce7a9 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
@@ -115,3 +115,5 @@ struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *dev)
 	return ctx;
 }
 EXPORT_SYMBOL(mtk_vcodec_get_curr_ctx);
+
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
