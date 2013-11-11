From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Nov 2013 18:00:04 +0100
Subject: [PATCH 20/23] ARM: signal: sigreturn_codes should be endian
 neutral to work in BE8
In-Reply-To: <20131111141258.GA3166@localhost.localdomain>
References: <20131111141258.GA3166@localhost.localdomain>
Message-ID: <20131111170004.GM14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 11, 2013 at 02:13:02PM +0000, Dave Martin wrote:
> On Tue, Nov 05, 2013 at 10:18:07PM +0100, Uwe Kleine-K?nig wrote:
> > > +	.section .rodata
> > > +	.global sigreturn_codes
> > > +	.type	sigreturn_codes, #object
> > > +
> > > +	.arm
> > This breaks a ARMv7-M build, see
> > http://arm-soc.lixom.net/buildlogs/misc/next-20131105-1-g2b29c44/buildall.arm.efm32_defconfig.log.failed
> 
> Hmmm, looks like we missed this scenario.
Did you see Victor already addressing this failure with a patch?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
