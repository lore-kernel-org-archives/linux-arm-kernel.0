From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Oct 2016 15:30:25 +0800
Subject: [PATCH v3 3/3] MAINTAINERS: add an entry for ZTE ZX DRM driver
In-Reply-To: <1476948625-8521-1-git-send-email-shawn.guo@linaro.org>
References: <1476948625-8521-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1476948625-8521-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
