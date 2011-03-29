From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Mar 2011 08:54:57 +0200
Subject: MACH_TYPE undeclared error
In-Reply-To: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
References: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
Message-ID: <20110329065457.GG30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 12:01:40PM +0530, Madhavi Manchala wrote:
> Dear All,
> 
> I have defined a MACHINE_START macro in my board C file as follows.
> 
> MACHINE_START(S3C2510, "S3C2510")
> 	.init_irq	= s3c2510_init_irq,
> 	.timer		= &s3c2510_time_init,
> MACHINE_END
> 
> When I try to compile this C file, I am seeing the following error message.
> 
> arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
> undeclared here (not in a function)
you need a line defining S3C2510 in arch/arm/tools/mach-types.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
