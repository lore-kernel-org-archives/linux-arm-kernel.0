From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Nov 2010 23:12:13 +0100
Subject: [PATCHv3 2/2] ARM: imx: Add mx53 support to common msl functions.
In-Reply-To: <20101109220207.GH6017@pengutronix.de>
References: <1288972551-21877-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1288972551-21877-2-git-send-email-Dinh.Nguyen@freescale.com>
	<20101109220207.GH6017@pengutronix.de>
Message-ID: <20101109221213.GC16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > -	if (!cpu_is_mx51())
> > +	if (!cpu_is_mx51() || !cpu_is_mx53())
> >  		return 0;
> 
> The code below runs for every SoC except i.MX51 and i.MX53. This is
> surely not what you want.
Hmm, for i.MX51 !cpu_is_mx53() is true, so the return 0 is always taken,
isn't it? :-)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
