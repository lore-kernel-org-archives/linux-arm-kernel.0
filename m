From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 30 Nov 2016 16:43:45 +0100
Subject: [PATCH v2 4/4] MAINTAINERS: add entry for Amlogic DRM drivers
In-Reply-To: <1480520625-13269-1-git-send-email-narmstrong@baylibre.com>
References: <1480520625-13269-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1480520625-13269-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as maintainer for Amlogic DRM drivers.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7..b2486fb 100644
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
+F:	Documentation/devicetree/bindings/display/meson/meson-drm.txt
+
 DRM DRIVERS FOR EXYNOS
 M:	Inki Dae <inki.dae@samsung.com>
 M:	Joonyoung Shim <jy0922.shim@samsung.com>
-- 
1.9.1
