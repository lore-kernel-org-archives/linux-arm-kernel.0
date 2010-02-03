From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Feb 2010 09:25:57 -0800
Subject: [PATCH 1/9] omap: define _toggle_gpio_edge_triggering only for
	OMAP1
In-Reply-To: <20100203171026.GO11354@pengutronix.de>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
	<20100203022555.26347.62876.stgit@baageli.muru.com>
	<20100203081313.GB11354@pengutronix.de>
	<20100203165754.GA22747@atomide.com>
	<20100203171026.GO11354@pengutronix.de>
Message-ID: <20100203172557.GE22747@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [100203 09:07]:
> Hello Tony,
> 
> On Wed, Feb 03, 2010 at 08:57:55AM -0800, Tony Lindgren wrote:
> > BTW, looks like with "git show --pretty=email" the From: field gets
> > messed up in the patch below. Author name shows OK in git though.
> > 
> > I wonder if that's a git bug for --pretty=email? Using version
> > 1.6.6.1 it seems.
> That's not a bug, but a feature.  This is normal rfcforgotthenumber mail
> header quoting.  (2822?)

Oh right, the email headers need to be ASCII still. Was not aware of
how umlauts should be encoded into the name though. It seems that
all my fellow Finns have erased the umlauts from their email addresses,
at least in my aliases file.

Tony

> 
> > 
> > Tony
> 
> > From 9198bcd39f558dd56823f1c9983e2252fc99a501 Mon Sep 17 00:00:00 2001
> > From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
> 
> Thanks
> Uwe
> 
> -- 
> Pengutronix e.K.                              | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                    | http://www.pengutronix.de/  |
