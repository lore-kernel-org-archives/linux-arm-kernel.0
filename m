From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 13 Nov 2017 18:15:31 +0800
Subject: [PATCH] MAINTAINERS: change maintainer for Rockchip drm drivers
Message-ID: <1510568131-28838-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For personal reasons, Mark Yao will leave rockchip,
can not continue maintain drm/rockchip, Sandy Huang
will take over the drm/rockchip.

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d77f22..31bf080 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4627,7 +4627,7 @@ F:	Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
 F:	Documentation/devicetree/bindings/display/renesas,du.txt
 
 DRM DRIVERS FOR ROCKCHIP
-M:	Mark Yao <mark.yao@rock-chips.com>
+M:	Sandy Huang <hjc@rock-chips.com>
 L:	dri-devel at lists.freedesktop.org
 S:	Maintained
 F:	drivers/gpu/drm/rockchip/
-- 
2.7.4
