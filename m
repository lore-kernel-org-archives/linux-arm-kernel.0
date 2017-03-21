From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Mar 2017 16:25:50 +0100
Subject: [PATCH v2 13/13] MAINTAINERS: update files for Amlogic DRM Driver
In-Reply-To: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490109950-21421-14-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dw-hdmi bindings and RST kerneldoc to maintained files.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e88154f..3df68c73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4256,6 +4256,8 @@ W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/gpu/drm/meson/
 F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+F:	Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+F:	Documentation/gpu/meson.rst
 T:	git git://anongit.freedesktop.org/drm/drm-meson
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
-- 
1.9.1
