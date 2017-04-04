From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  4 Apr 2017 14:15:31 +0200
Subject: [PATCH v3 11/11] MAINTAINERS: update files for Amlogic DRM Driver
In-Reply-To: <1491308131-22071-1-git-send-email-narmstrong@baylibre.com>
References: <1491308131-22071-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1491308131-22071-12-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dw-hdmi bindings and RST kerneldoc to maintained files.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d3eb6e..8471ff1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4258,6 +4258,8 @@ W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/gpu/drm/meson/
 F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+F:	Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+F:	Documentation/gpu/meson.rst
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVERS FOR EXYNOS
-- 
1.9.1
