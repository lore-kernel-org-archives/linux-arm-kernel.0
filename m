From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Feb 2010 08:57:55 -0800
Subject: [PATCH 1/9] omap: define _toggle_gpio_edge_triggering only for
	OMAP1
In-Reply-To: <20100203081313.GB11354@pengutronix.de>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
	<20100203022555.26347.62876.stgit@baageli.muru.com>
	<20100203081313.GB11354@pengutronix.de>
Message-ID: <20100203165754.GA22747@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [100203 00:10]:
> Hi Tony,
> 
> On Tue, Feb 02, 2010 at 06:25:55PM -0800, Tony Lindgren wrote:
> > From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > 
> > The only usage of _toggle_gpio_edge_triggering is in an
> > CONFIG_ARCH_OMAP1 is defined, too.
> This sentence is broken, isn't it?  I guess git commit played tricks on
> me here and removed a line, something like:
> 
> 	#ifdef CONFIG_ARCH_OMAP1 block, so only provide it if
> 
> Can you add it back?  I'd recommend doing the line break before the "an"
> in the first line instead of behind it.

Sure, updated patch below. The description makes more sense now :)

BTW, looks like with "git show --pretty=email" the From: field gets
messed up in the patch below. Author name shows OK in git though.

I wonder if that's a git bug for --pretty=email? Using version
1.6.6.1 it seems.

Tony
