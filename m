From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 19 Jun 2018 15:34:11 +0800
Subject: [PATCH v6 10/29] drm/mediatek: add the DSI1 for component init
 condition
In-Reply-To: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529393670-26862-11-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the DSI1 for component init condition

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 17b681686471..ff974d82a4a6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -280,6 +280,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	    comp_id == DDP_COMPONENT_DPI0 ||
 	    comp_id == DDP_COMPONENT_DPI1 ||
 	    comp_id == DDP_COMPONENT_DSI0 ||
+	    comp_id == DDP_COMPONENT_DSI1 ||
 	    comp_id == DDP_COMPONENT_DSI2 ||
 	    comp_id == DDP_COMPONENT_DSI3 ||
 	    comp_id == DDP_COMPONENT_PWM0) {
-- 
2.12.5
