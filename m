From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  9 Dec 2015 12:48:24 +0100
Subject: [PATCH v2 11/14] MAINTAINERS: add maintainer and reviewers for the
 etnaviv DRM driver
In-Reply-To: <1449661707-30532-1-git-send-email-l.stach@pengutronix.de>
References: <1449661707-30532-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1449661707-30532-11-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b28828..9990a3b9b686 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3741,6 +3741,15 @@ S:	Maintained
 F:	drivers/gpu/drm/sti
 F:	Documentation/devicetree/bindings/display/st,stih4xx.txt
 
+DRM DRIVERS FOR VIVANTE GPU IP
+M:	Lucas Stach <l.stach@pengutronix.de>
+R:	Russell King <linux+etnaviv@arm.linux.org.uk>
+R:	Christian Gmeiner <christian.gmeiner@gmail.com>
+L:	dri-devel at lists.freedesktop.org
+S:	Maintained
+F:	drivers/gpu/drm/etnaviv
+F:	Documentation/devicetree/bindings/display/etnaviv
+
 DSBR100 USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media at vger.kernel.org
-- 
2.6.2
