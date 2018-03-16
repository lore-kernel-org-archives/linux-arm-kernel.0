From: anson.huang@nxp.com (Anson Huang)
Date: Fri, 16 Mar 2018 01:22:12 +0000
Subject: [GIT PULL 1/6] i.MX drivers updates for 4.17
In-Reply-To: <20180316004719.GL26859@dragon>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
 <CAK8P3a32SL4vaD+o8wRWDnnv0e0k5qyER9Ly-2j9PZAOrkyV6w@mail.gmail.com>
 <20180316004719.GL26859@dragon>
Message-ID: <AM3PR04MB1315974FBA246FE77175FB96F5D70@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Friday, March 16, 2018 8:47 AM
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: arm-soc <arm@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>;
> Sascha Hauer <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> Linux ARM <linux-arm-kernel@lists.infradead.org>; Anson Huang
> <anson.huang@nxp.com>; Lucas Stach <l.stach@pengutronix.de>; A.s. Dong
> <aisheng.dong@nxp.com>
> Subject: Re: [GIT PULL 1/6] i.MX drivers updates for 4.17
> 
> On Thu, Mar 15, 2018 at 04:25:10PM +0100, Arnd Bergmann wrote:
> > On Thu, Mar 15, 2018 at 12:36 PM, Shawn Guo <shawnguo@kernel.org>
> wrote:
> > > The following changes since commit
> 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> > >
> > >   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> > >
> > > are available in the git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> > > tags/imx-drivers-4.17
> > >
> > > for you to fetch changes up to
> f40a1e3705be23e845fbeec66acf3a6582524145:
> > >
> > >   soc: imx: gpc: ARM power domain should be always-on (2018-02-12
> > > 13:07:48 +0800)
> > >
> > > ----------------------------------------------------------------
> > > i.MX drivers update for 4.17:
> > >  - Set GENPD_FLAG_ALWAYS_ON flag for ARM power domain to avoid
> incorrect
> > >    power state in sysfs pm_genpd_summary output.
> >
> > Pulled into next/drivers. I can't really tell from the patch
> > description whether this is urgent or not. Can you confirm that we
> > don't want this in 4.16 or older kernels?
> 
> My understanding is that it's not so urgent or critical for older kernels.
> @Anson, let us know if you think differently.
> 
> Shawn

This patch is NOT critical from function perspective, so it is NOT urgent.

Anson.
