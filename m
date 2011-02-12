From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Sat, 12 Feb 2011 21:15:20 +0100
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <4D55AA65.2020101@pengutronix.de>
References: <20110211081050.GD27982@pengutronix.de>
	<1297458388-23361-1-git-send-email-GNUtoo@no-log.org>
	<4D55AA65.2020101@pengutronix.de>
Message-ID: <1297541720.2942.3.camel@gnutoo-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-11 at 22:30 +0100, Marc Kleine-Budde wrote:
> here slipped some spaces in
> > +     .init_irq = mx31_init_irq,
> > +        .timer = &mx31bug_timer,
> 
> dito 
Sorry, I looked carefully after such errors at first,
before sending the first patch,
but then I forgot to look after it when fixing what the comments pointed
out.

I'll fix it in the new patch I'll resend, I'll try to find how to make
git-send-email send a v3 too(last time I failed, because I looked for
some command that did it on some wiki that was not very up to date)

Denis.
