From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Wed, 20 Jun 2018 16:19:07 +0800
Subject: [PATCH v7 05/29] drm/mediatek: add ddp component PWM1
In-Reply-To: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529482771-2153-6-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add component PWM1 in mtk_ddp_matches

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 87acf6be87f6..a5c7ac2d162d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -232,6 +232,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
 	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
 	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
+	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
 	[DDP_COMPONENT_RDMA0]	= { MTK_DISP_RDMA,	0, NULL },
 	[DDP_COMPONENT_RDMA1]	= { MTK_DISP_RDMA,	1, NULL },
 	[DDP_COMPONENT_RDMA2]	= { MTK_DISP_RDMA,	2, NULL },
-- 
2.12.5
