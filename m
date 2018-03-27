From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Tue, 27 Mar 2018 10:23:53 +0200
Subject: [PATCH 2/5] drm/rockchip: fixup comment for gem_free_object_unlocked
In-Reply-To: <20180327082356.24516-1-daniel.vetter@ffwll.ch>
References: <20180327082356.24516-1-daniel.vetter@ffwll.ch>
Message-ID: <20180327082356.24516-2-daniel.vetter@ffwll.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just want to clean out all grep hits. gem_free_object is deprecated.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko St?bner" <heiko@sntech.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 074db7a92809..a8db758d523e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -357,8 +357,8 @@ rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
 }
 
 /*
- * rockchip_gem_free_object - (struct drm_driver)->gem_free_object callback
- * function
+ * rockchip_gem_free_object - (struct drm_driver)->gem_free_object_unlocked
+ * callback function
  */
 void rockchip_gem_free_object(struct drm_gem_object *obj)
 {
-- 
2.16.2
