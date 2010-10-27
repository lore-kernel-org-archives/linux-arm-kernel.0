From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 Oct 2010 15:56:42 +0200
Subject: [PATCH] ARM: imx: Add some core definitions for MX53
In-Reply-To: <4CC82A13.8000909@eukrea.com>
References: <1288119235-7036-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101027082958.GA6797@angua.secretlab.ca>
	<20101027090921.GB8554@pengutronix.de>
	<20101027102253.GA7822@angua.secretlab.ca>
	<20101027132213.GJ6017@pengutronix.de>
	<4CC82A13.8000909@eukrea.com>
Message-ID: <20101027135642.GM6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 03:33:07PM +0200, Eric B?nard wrote:
> Hi,
>
> Le 27/10/2010 15:22, Sascha Hauer a ?crit :
> > That's a way we can go but only if the common name is not MX5 or MX5x.
> > We've done it with the mx21/27 and it failed when the mx25 came out
> > which was completely incompatible. Since then everybody looking at
> > the code must know that mx2x is mx21/27 but not mx25. I suggest
> > something like MX513 instead.
> >
> MX513 is the partnumber of a member of the i.MX51 family so that's maybe 
> not the best choice.

Yes, I know. Is MX5_1_3 better? Any other suggestions?

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
