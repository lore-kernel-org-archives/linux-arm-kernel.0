From: seanpaul@chromium.org (Sean Paul)
Date: Fri,  8 Sep 2017 10:46:18 -0400
Subject: [PATCH] drm/rockchip: Add forward declarations to cdn_dp_device and
 audio_info
Message-ID: <20170908144637.35914-1-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add forward declarations in cdn-dp-reg.h to cdn_dp_device and audio_info

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index c4bbb4a83319..84bdb4a49ae2 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -459,6 +459,9 @@ enum vic_bt_type {
 	BT_709 = 0x1,
 };
 
+struct cdn_dp_device;
+struct audio_info;
+
 void cdn_dp_clock_reset(struct cdn_dp_device *dp);
 
 void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, unsigned long clk);
-- 
2.14.1.581.gf28d330327-goog
