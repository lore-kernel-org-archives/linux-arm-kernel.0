From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Mar 2017 09:40:52 +0200
Subject: [PATCH 2/2] MAINTAINERS: Add sun4i-drm git repo
In-Reply-To: <20170331074052.28878-1-maxime.ripard@free-electrons.com>
References: <20170331074052.28878-1-maxime.ripard@free-electrons.com>
Message-ID: <20170331074052.28878-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the git tree where the sun4i-drm patches are hosted.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c18a2b89ce83..f9f5128e4177 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4252,6 +4252,7 @@ L:	dri-devel at lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/sun4i/
 F:	Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git
 
 DRM DRIVERS FOR AMLOGIC SOCS
 M:	Neil Armstrong <narmstrong@baylibre.com>
-- 
2.11.0
