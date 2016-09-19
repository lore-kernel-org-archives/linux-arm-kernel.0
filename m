From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 19 Sep 2016 10:34:20 +0100
Subject: [PATCH 2/2] drm/virtio: kconfig: Fixup white space.
In-Reply-To: <1474277660-5196-1-git-send-email-peter.griffin@linaro.org>
References: <1474277660-5196-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1474277660-5196-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tabs instead of spaces.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/virtio/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
index 90357d9..2d83932 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -2,10 +2,10 @@ config DRM_VIRTIO_GPU
 	tristate "Virtio GPU driver"
 	depends on DRM
 	select VIRTIO
-        select DRM_KMS_HELPER
-        select DRM_TTM
+	select DRM_KMS_HELPER
+	select DRM_TTM
 	help
 	   This is the virtual GPU driver for virtio.  It can be used with
-           QEMU based VMMs (like KVM or Xen).
+	   QEMU based VMMs (like KVM or Xen).
 
 	   If unsure say M.
-- 
1.9.1
