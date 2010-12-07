From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 6 Dec 2010 19:08:54 -0700 (MST)
Subject: [PATCH RESEND] MAINTAINERS: OMAP: hwmod: update hwmod code, data
	maintainership
Message-ID: <alpine.DEB.2.00.1012061908110.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add myself and Beno?t as co-maintainers of the OMAP hwmod core code.
(The OMAP hwmod code manages the integration of IP blocks on the OMAP SoC
family.)

Add Beno?t as the maintainer of OMAP4-based SoC hwmod mode.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
---

With the correct address for lakml this time.

 MAINTAINERS |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3be8b3..b10a91c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4329,6 +4329,20 @@ M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
 F:	drivers/char/hw_random/omap-rng.c
 
+OMAP HWMOD SUPPORT
+M:	Beno?t Cousson <b-cousson@ti.com>
+M:	Paul Walmsley <paul@pwsan.com>
+L:	linux-omap at vger.kernel.org
+S:	Maintained
+F:	arch/arm/mach-omap2/omap_hwmod.c
+F:	arch/arm/plat-omap/include/plat/omap_hwmod.h
+
+OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
+M:	Beno?t Cousson <b-cousson@ti.com>
+L:	linux-omap at vger.kernel.org
+S:	Maintained
+F:	arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+
 OMAP USB SUPPORT
 M:	Felipe Balbi <balbi@ti.com>
 M:	David Brownell <dbrownell@users.sourceforge.net>
-- 
1.7.2.3
