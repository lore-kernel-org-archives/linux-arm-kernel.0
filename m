From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:15 +0200
Subject: [PATCH 05/13] driver core: fix docbook for device_private.device
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This field refers to the public device struct, not to classes.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/base/base.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index fd3347d..29c985e 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -63,7 +63,7 @@ struct driver_private {
  *	binding of drivers which were unable to get all the resources needed by
  *	the device; typically because it depends on another driver getting
  *	probed first.
- * @device - pointer back to the struct class that this structure is
+ * @device - pointer back to the struct device that this structure is
  * associated with.
  *
  * Nothing outside of the driver core should ever touch these fields.
-- 
2.4.1
