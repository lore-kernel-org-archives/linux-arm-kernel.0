From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Oct 2010 11:28:16 +0200
Subject: [PATCH v3] TWL IRQ: Fix fucntion declaration warnings
In-Reply-To: <20101019090613.GA2736@sortiz-mobl>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
	<1286315819-5906-4-git-send-email-manjugk@ti.com>
	<20101019090613.GA2736@sortiz-mobl>
Message-ID: <20101019092816.GD11713@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 11:06:14AM +0200, Samuel Ortiz wrote:
> Hi Manjunath,
> 
> On Wed, Oct 06, 2010 at 03:26:59AM +0530, G, Manjunath Kondaiah wrote:
> > Fixes following sparse warnings for twl4030 and twl6030 irq files.
> > 
> > drivers/mfd/twl4030-irq.c:783:5: warning: symbol 'twl4030_init_irq' was not declared. Should it be static?
> > drivers/mfd/twl4030-irq.c:863:5: warning: symbol 'twl4030_exit_irq' was not declared. Should it be static?
> > drivers/mfd/twl4030-irq.c:873:5: warning: symbol 'twl4030_init_chip_irq' was not declared. Should it be static?
> > 
> > drivers/mfd/twl6030-irq.c:226:5: warning: symbol 'twl6030_init_irq' was not declared. Should it be static?
> > drivers/mfd/twl6030-irq.c:290:5: warning: symbol 'twl6030_exit_irq' was not declared. Should it be static?
> >
> Patch applied, thanks.
I didn't get the original patch, so I just now noticed the typo in the
Subject.  You might want to do s/fucntion/function/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
