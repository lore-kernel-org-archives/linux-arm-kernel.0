From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 10 Sep 2011 16:08:52 +0200
Subject: [PATCH v2 1/3] ARM: mx28evk: add platform data for saif
In-Reply-To: <20110909134105.GT1912@pengutronix.de>
References: <1315403858-9904-1-git-send-email-b29396@freescale.com>
	<1315403858-9904-2-git-send-email-b29396@freescale.com>
	<20110907181811.GX28816@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F77223C8CB@039-SN1MPN1-003.039d.mgd.msft.net>
	<20110909134105.GT1912@pengutronix.de>
Message-ID: <20110910140852.GP28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Sep 09, 2011 at 03:41:05PM +0200, Wolfram Sang wrote:
> > > >  extern const struct mxs_saif_data mx28_saif_data[] __initconst;
> > > > -#define mx28_add_saif(id)
> > > mxs_add_saif(&mx28_saif_data[id])
> > > > +#define mx28_add_saif(id, pdata) \
> > > > +	mxs_add_saif(&mx28_saif_data[id], pdata)
> > > should it be a seperate patch to add pdata for saif devices?
> > How do you suggest to separate?
> > All changes are mainly to add saif pdata.
> > You mean to move DIGCTL related saif pdata function to another patch?
> 
> I think he meant one patch for adding the functions in clock-mx28.c and
> one patch to use the stuff when adding the pdata. Uwe?
yeah.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
