From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 3 May 2012 08:42:11 +0000
Subject: [PATCH v4 04/39] ARM: OMAP2+: gpmc: Acquire NAND CS value
In-Reply-To: <4FA05292.7030902@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <10220de398d22fad5de783d8f58fc55ebac85338.1335874494.git.afzal@ti.com>
 <4FA05292.7030902@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9829B0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, May 02, 2012 at 02:46:02, Hunter, Jon wrote:
> > Some boards depend on bootloader to update chip select value for NAND.
> > It is felt that Kernel should not depend on bootloader to get CS, as
> > for a particular board CS is hardwired and is fixed, hence this can
> > directly be updated in Kernel. But as CS value for boards that depend
> > on this behaviour is not available, educate gpmc driver to acquire
> > chip select value for NAND. this ideally should be removed once CS
> > for those boards are available.
> 
> Do you know how many boards require this? If so which are those boards?

devkit8000, beagle board, omap3touchbook, overo.

Beagle board, found out to be zero.

> Should this code be marked with a FIXME?

Will let Tony decide it.

Regards
Afzal
