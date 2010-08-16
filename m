From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Aug 2010 06:53:40 +0200
Subject: [PATCH v2] ARM: imx: fix build failure concerning otg/ulpi
In-Reply-To: <4C6783C7.1030604@compulab.co.il>
References: <4C65246E.1000906@ru.mvista.com>
	<1281701210-27776-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4C6783C7.1030604@compulab.co.il>
Message-ID: <20100816045340.GA17038@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Igor,

On Sun, Aug 15, 2010 at 09:05:59AM +0300, Igor Grinberg wrote:
> On 08/13/10 15:06, Uwe Kleine-K?nig wrote:
> > The build failure was introduced by
> >
> > 	13dd0c9 (USB: otg/ulpi: extend the generic ulpi driver.)
> >
> > Cc: Igor Grinberg <grinberg@compulab.co.il>
> > Cc: Mike Rapoport <mike@compulab.co.il>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >   
> 
> I've based my patches on v2.6.35-rc6, so I could not patch
> those imx variants, sorry...
> But I did deal with mach-pca100.c, so I think moving it from
> mach-mx2 to mach-imx is what made it miss my patch.
> 
> Anyway, this looks like the right addition.
I assume this is an Ack?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
