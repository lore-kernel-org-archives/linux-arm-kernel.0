From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 29 Sep 2016 11:22:02 +0800
Subject: [PATCH] drm/mediatek: fix a typo
Message-ID: <1475119322-58657-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the typo: OD_RELAYMODE->OD_CFG

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index df33b3c..aa5f20f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -123,7 +123,7 @@ static void mtk_od_config(struct mtk_ddp_comp *comp, unsigned int w,
 			  unsigned int bpc)
 {
 	writel(w << 16 | h, comp->regs + DISP_OD_SIZE);
-	writel(OD_RELAYMODE, comp->regs + OD_RELAYMODE);
+	writel(OD_RELAYMODE, comp->regs + OD_CFG);
 	mtk_dither_set(comp, bpc, DISP_OD_CFG);
 }
 
-- 
1.7.9.5
