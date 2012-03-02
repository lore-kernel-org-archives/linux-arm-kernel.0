From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 2 Mar 2012 16:11:52 +0100
Subject: [GIT PULL] i.MX3 patches
In-Reply-To: <201203021507.57409.arnd@arndb.de>
References: <20120302080105.GJ3852@pengutronix.de>
 <201203021507.57409.arnd@arndb.de>
Message-ID: <20120302151152.GO3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 03:07:56PM +0000, Arnd Bergmann wrote:
> On Friday 02 March 2012, Sascha Hauer wrote:
> > Hi Arnd,
> > 
> > Please pull the following i.MX3 specific patches for -next. Note
> > that 1/2 depends on your imx/cleanup branch since it includes
> > crmregs-imx3.h which is created in this branch.
> > 
> > The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:
> > 
> >   Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.pengutronix.de/git/imx/linux-2.6.git features/imx3
> 
> Pulled into next/soc. 
> 
> I got a merge conflict against Nico's 4a3ea244 "ARM: plat-mxc: hook special idle
> handlers to arm_pm_idle" and did the obvious merge below. Please complain
> if this needs some other resolution.

Looks good.

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
