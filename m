From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  2 Mar 2017 16:40:07 +0100
Subject: [PATCH 11/11] MAINTAINERS: update files for Amlogic DRM Driver
In-Reply-To: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
References: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1488469207-523-12-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dw-hdmi bindings to maintained files.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d302c0..3869d7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4255,6 +4255,7 @@ W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/gpu/drm/meson/
 F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+F:	Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
 
 DRM DRIVERS FOR EXYNOS
 M:	Inki Dae <inki.dae@samsung.com>
-- 
1.9.1
