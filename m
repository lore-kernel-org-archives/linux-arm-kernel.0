From: jc@linux.com (Jesse Chan)
Date: Sun, 19 Nov 2017 22:26:07 -0800
Subject: [PATCH] media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION
Message-ID: <20171120062607.124734-1-jc@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jesse Chan <jc@linux.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
index 113b2097f061..d8212d759067 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
@@ -51,3 +51,6 @@ int mtk_vcodec_wait_for_done_ctx(struct mtk_vcodec_ctx  *ctx, int command,
 	return status;
 }
 EXPORT_SYMBOL(mtk_vcodec_wait_for_done_ctx);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mediatek video codec driver");
-- 
2.14.1
