From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 17:56:15 -0700
Subject: [PATCH 2/7] MAINTAINERS: Add myself for the new VC4 (RPi GPU)
 graphics driver.
In-Reply-To: <1439427380-2436-1-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
Message-ID: <1439427380-2436-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..d0dc42c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3573,6 +3573,12 @@ S:	Maintained
 F:	drivers/gpu/drm/rockchip/
 F:	Documentation/devicetree/bindings/video/rockchip*
 
+DRM DRIVERS FOR VC4
+M:	Eric Anholt <eric@anholt.net>
+T:	git git://github.com/anholt/linux
+S:	Maintained
+F:	drivers/gpu/drm/vc4/*
+
 DSBR100 USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media at vger.kernel.org
-- 
2.1.4
