From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Apr 2011 16:29:36 +0200
Subject: [PATCH] plat-mxc: Provide irq_chip name for GPIO IRQs
In-Reply-To: <20110301083415.GA2212@pengutronix.de>
References: <1296489624-21355-1-git-send-email-alexander.stein@systec-electronic.com>
	<201103010838.37197.alexander.stein@systec-electronic.com>
	<20110301083415.GA2212@pengutronix.de>
Message-ID: <20110404142936.GF30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 09:34:15AM +0100, Wolfram Sang wrote:
> Hi,
> 
> > >  static struct irq_chip gpio_irq_chip = {
> > > +	.name = "GPIO",
> 
> I'd suggest a more specific name, e.g. "i.MX GPIO"? You can then also
> add my
> 
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
This comment wasn't addressed. Does someone care to follow up?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
