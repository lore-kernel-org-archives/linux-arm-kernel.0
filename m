From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:39 +0100
Subject: [PATCH v2 10/19] drm/sun4i: backend: Fix define typo
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <6b2e872b611b733a98a38902a2197b70c725e0b9.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was a typo in the width spelling of the (unused)
SUN4I_BACKEND_IYUVLINEWITDTH_REG macro. Fix it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index b5edf2d50a24..1ca8b7db6807 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -112,7 +112,9 @@
 #define SUN4I_BACKEND_SPRALPHACTL_REG		0x90c
 #define SUN4I_BACKEND_IYUVCTL_REG		0x920
 #define SUN4I_BACKEND_IYUVADD_REG(c)		(0x930 + (0x4 * (c)))
-#define SUN4I_BACKEND_IYUVLINEWITDTH_REG(c)	(0x940 + (0x4 * (c)))
+
+#define SUN4I_BACKEND_IYUVLINEWIDTH_REG(c)	(0x940 + (0x4 * (c)))
+
 #define SUN4I_BACKEND_YGCOEF_REG(c)		(0x950 + (0x4 * (c)))
 #define SUN4I_BACKEND_YGCONS_REG		0x95c
 #define SUN4I_BACKEND_URCOEF_REG(c)		(0x960 + (0x4 * (c)))
-- 
git-series 0.9.1
