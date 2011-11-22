From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Nov 2011 10:07:18 +0100
Subject: [PATCH] ARM: imx: drop 'ARCH_MX31' and 'ARCH_MX35'
In-Reply-To: <20111121133603.GR9581@n2100.arm.linux.org.uk>
References: <1321882445.32195.3.camel@x61.thuisdomein>
 <20111121133603.GR9581@n2100.arm.linux.org.uk>
Message-ID: <20111122090718.GD27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 01:36:03PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2011 at 02:34:05PM +0100, Paul Bolle wrote:
> > Commit 27ad4bf72a ("ARM: imx: move mx3 support to mach-imx") kept
> > ARCH_MX31 and ARCH_MX35 'for compatibility'. Now that they aren't
> > actually used anymore, they can be dropped entirely.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> Sascha should be handing this patch.
> 
> ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> M:      Sascha Hauer <kernel@pengutronix.de>
> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> T:      git git://git.pengutronix.de/git/imx/linux-2.6.git
> F:      arch/arm/mach-mx*/
> F:      arch/arm/plat-mxc/
> 
> It may be an idea if MAINTAINERS gets updated too, so these patches find
> their way to the right person...


Indeed, I never realized that it's missing arch/arm/mach-imx

8<----------------------------------------

MAINTAINERS: Add missing directory

arch/arm/mach-imx/ is part of the i.MX support. Add it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 071a996..c9ae02a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -789,6 +789,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
 F:	arch/arm/mach-mx*/
+F:	arch/arm/mach-imx/
 F:	arch/arm/plat-mxc/
 
 ARM/FREESCALE IMX51
-- 
1.7.7.1

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
