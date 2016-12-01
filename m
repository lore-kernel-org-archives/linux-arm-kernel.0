From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  1 Dec 2016 10:06:00 +0100
Subject: [PATCH v3 4/4] MAINTAINERS: add entry for Amlogic DRM drivers
In-Reply-To: <1480583160-31806-1-git-send-email-narmstrong@baylibre.com>
References: <1480583160-31806-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1480583160-31806-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as maintainer for Amlogic DRM drivers.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7..b1ad45b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4078,6 +4078,15 @@ S:	Supported
 F:	drivers/gpu/drm/sun4i/
 F:	Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
 
+DRM DRIVERS FOR AMLOGIC SOCS
+M:	Neil Armstrong <narmstrong@baylibre.com>
+L:	dri-devel at lists.freedesktop.org
+L:	linux-amlogic at lists.infradead.org
+W:	http://linux-meson.com/
+S:	Supported
+F:	drivers/gpu/drm/meson/
+F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+
 DRM DRIVERS FOR EXYNOS
 M:	Inki Dae <inki.dae@samsung.com>
 M:	Joonyoung Shim <jy0922.shim@samsung.com>
-- 
1.9.1
