From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:13:00 +0200
Subject: [PATCH 05/18] drm/sun4i: tcon: remove unused function
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7d8e9b8d77c9bef3258e97a06aab42314355acf4.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though that function is defined in the TCON header, it's not defined
nor used anywhere. Remove the prototype.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index e3c50ecdcd04..552c88ec16be 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -194,8 +194,6 @@ void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel);
 void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 
 /* Mode Related Controls */
-void sun4i_tcon_switch_interlace(struct sun4i_tcon *tcon,
-				 bool enable);
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			struct drm_encoder *encoder);
 void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
-- 
git-series 0.9.1
