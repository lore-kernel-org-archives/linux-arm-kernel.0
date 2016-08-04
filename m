From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 4 Aug 2016 10:59:51 +0800
Subject: [PATCH v2 1/7] drm/mediatek: Remove mtk_drm_crtc_check_flush
In-Reply-To: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1470279597-60453-2-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

This function no longer exists.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
index 81e5566..4d32cf1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
@@ -22,7 +22,6 @@
 
 int mtk_drm_crtc_enable_vblank(struct drm_device *drm, unsigned int pipe);
 void mtk_drm_crtc_disable_vblank(struct drm_device *drm, unsigned int pipe);
-void mtk_drm_crtc_check_flush(struct drm_crtc *crtc);
 void mtk_drm_crtc_commit(struct drm_crtc *crtc);
 void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl);
 int mtk_drm_crtc_create(struct drm_device *drm_dev,
-- 
1.7.9.5
