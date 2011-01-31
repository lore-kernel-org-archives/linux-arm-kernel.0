From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 31 Jan 2011 16:02:11 -0700 (MST)
Subject: [PATCH] MAINTAINERS: add entry for OMAP powerdomain/clockdomain
	per-SoC layer support
Message-ID: <alpine.DEB.2.00.1101310955300.16671@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add Rajendra Nayak and myself as maintainers for the OMAP
powerdomain/clockdomain per-SoC layer code.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

This patch is being sent for comment only; Tony will probably queue 
this up with the rest of the OMAP patches in the .39 window.

 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55592f8..d203d8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4451,6 +4451,16 @@ L:	linux-omap at vger.kernel.org
 S:	Maintained
 F:	arch/arm/*omap*/*pm*
 
+OMAP POWERDOMAIN/CLOCKDOMAIN SOC ADAPTATION LAYER SUPPORT
+M:	Rajendra Nayak <rnayak@ti.com>
+M:	Paul Walmsley <paul@pwsan.com>
+L:	linux-omap at vger.kernel.org
+S:	Maintained
+F:	arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+F:	arch/arm/mach-omap2/powerdomain44xx.c
+F:	arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+F:	arch/arm/mach-omap2/clockdomain44xx.c
+
 OMAP AUDIO SUPPORT
 M:	Jarkko Nikula <jhnikula@gmail.com>
 L:	alsa-devel at alsa-project.org (subscribers-only)
-- 
1.7.2.3
