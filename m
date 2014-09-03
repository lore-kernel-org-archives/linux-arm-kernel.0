From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Wed, 3 Sep 2014 14:16:50 +0200
Subject: mx28 battery charger support
In-Reply-To: <CAOMZO5BNNBzJA0Q-Ls-c7ch-LXEhkuYxFwxJk72d7ZAL5mwJOQ@mail.gmail.com>
References: <20140902103913.GA9417@piout.net>
 <CAOMZO5BNNBzJA0Q-Ls-c7ch-LXEhkuYxFwxJk72d7ZAL5mwJOQ@mail.gmail.com>
Message-ID: <20140903121650.GJ22227@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Sep 02, 2014 at 10:20:04AM -0300, Fabio Estevam wrote:
> On Tue, Sep 2, 2014 at 7:39 AM, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > I'm having a look at the battery charger on i.mx28. Is there any
> > mainline driver or any attempt at mainlining a driver? The IP is not
> > documented in the i.MX28 Applications Processor Reference Manual but
> > there is an existing driver in the Linux 2.6.35 sources from Freescale [1].
> >
> > I would love not being stuck with such an old version ;)
> >
> > [1] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/power/mxs?h=imx_2.6.35_maintain
> 
> I haven't seen any patches for upstreaming the battery charger on mxs yet..
> 
> In this discussion Robert Schwebel reports to be using a mainline
> kernel with the battery charger driver on mx23:
> https://community.freescale.com/thread/312468
> 
> Adding Robert in case he could comment on this.

Unfortunately, we don't have a mainline-quality driver yet. We made an
ugly hack at that time that worked somehow, but then our project time
went out and the driver was left in the customer BSP in its current
state.

I can see if we can split out the patches, but mit could need some time,
as I'm on holiday.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
