From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 26 Feb 2010 11:46:57 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <1267179548.2778.41.camel@realization>
References: <1267095523.2722.40.camel@realization>
	<505892.36787.qm@web51002.mail.re2.yahoo.com>
	<20100226093621.GB3088@pengutronix.de>
	<1267179548.2778.41.camel@realization>
Message-ID: <20100226104657.GA8120@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > > MACH name is MX35_3DS and board name is mach-mx35pdk.c
> > Oh, I must have missed that when massrenaming the machine files.
> > (commit 321ed164).  Sorry :-)
> > 
> > Best regards
> > Uwe
> > 
> 
> Uwe, so what is the next step? we can re-rename the machine file
> to mach-mx31pdk.c?
I suggest to do

	mv mach-mx35pdk.c mach-mx35_3ds.c

to make it consistant.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
