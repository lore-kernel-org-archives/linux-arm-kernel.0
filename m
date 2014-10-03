From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  3 Oct 2014 13:52:01 +0200
Subject: [PATCH v2 1/5] simplefb: Add simplefb MAINTAINERS entry
In-Reply-To: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
References: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1412337125-14388-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the discussion about adding clock handling code to simplefb, it became
clear that simplefb currently does not have an active maintainer.

I've discussed this with Stephen Warren <swarren@wwwdotorg.org>, the original
author of simplefb, and with his permisson I'm picking up maintainership of
simplefb.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3705430..01a5fd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8289,6 +8289,13 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIMPLEFB FB DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-fbdev at vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/video/simple-framebuffer.txt
+F:	drivers/video/fbdev/simplefb.c
+
 SH_VEU V4L2 MEM2MEM DRIVER
 L:	linux-media at vger.kernel.org
 S:	Orphan
-- 
2.1.0
