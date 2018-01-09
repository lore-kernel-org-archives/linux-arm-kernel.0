From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:28 +0100
Subject: [PATCH 09/19] drm/sun4i: backend: Fix structure indentation
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <70ef1982341be561bf81479efe0090c7276891fa.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i_plane_desc structure was somehow indented to two tabulations
instead of one as we shoud do. Fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 4652b25be0d2..f03da16eb92a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -20,10 +20,10 @@
 #include "sunxi_engine.h"
 
 struct sun4i_plane_desc {
-	       enum drm_plane_type     type;
-	       u8                      pipe;
-	       const uint32_t          *formats;
-	       uint32_t                nformats;
+	enum drm_plane_type     type;
+	u8                      pipe;
+	const uint32_t          *formats;
+	uint32_t                nformats;
 };
 
 static void sun4i_backend_layer_reset(struct drm_plane *plane)
-- 
git-series 0.9.1
