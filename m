From: stu.hsieh@mediatek.com (stu.hsieh at mediatek.com)
Date: Fri, 25 May 2018 10:34:22 +0800
Subject: [PATCH v3 5/8] drm/mediatek: add ddp component OD1
In-Reply-To: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527215665-11937-6-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stu Hsieh <stu.hsieh@mediatek.com>

This patch add the component OD1 and
rename the OD to OD1

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index eee3c0cc2632..9b19fc4423f1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -50,7 +50,8 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_DSI0,
 	DDP_COMPONENT_DSI1,
 	DDP_COMPONENT_GAMMA,
-	DDP_COMPONENT_OD,
+	DDP_COMPONENT_OD0,
+	DDP_COMPONENT_OD1,
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_PWM0,
-- 
2.12.5
