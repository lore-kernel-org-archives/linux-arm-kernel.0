From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 31 Oct 2016 17:17:25 +0800
Subject: [PATCH v4 3/3] MAINTAINERS: add an entry for ZTE ZX DRM driver
In-Reply-To: <1477905445-4983-1-git-send-email-shawnguo@kernel.org>
References: <1477905445-4983-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1477905445-4983-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Add myself as the maintainer of ZTE ZX DRM driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7e0064..907dbd3261c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4281,6 +4281,13 @@ S:	Maintained
 F:	drivers/gpu/drm/tilcdc/
 F:	Documentation/devicetree/bindings/display/tilcdc/
 
+DRM DRIVERS FOR ZTE ZX
+M:	Shawn Guo <shawnguo@kernel.org>
+L:	dri-devel at lists.freedesktop.org
+S:	Maintained
+F:	drivers/gpu/drm/zte/
+F:	Documentation/devicetree/bindings/display/zte,vou.txt
+
 DSBR100 USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media at vger.kernel.org
-- 
1.9.1
