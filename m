From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 08:53:27 +0100
Subject: [PATCH 08/13] clocksource: convert ARM 32-bit down counting
	clocksources
In-Reply-To: <BANLkTi=7Lxs6gMfi-n4_4cdD4C2G887E=g@mail.gmail.com>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
	<BANLkTi=7Lxs6gMfi-n4_4cdD4C2G887E=g@mail.gmail.com>
Message-ID: <20110511075327.GD15120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 11:04:38PM +0200, Linus Walleij wrote:
> 2011/5/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > Convert MXC, Nomadik and Orion 32-bit down-counting clocksources to
> > generic mmio clocksource infrastructure.
> >
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Alessandro Rubini <rubini@unipv.it>
> > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > Cc: Lennert Buytenhek <kernel@wantstofly.org>
> > Cc: Nicolas Pitre <nico@fluxnic.net>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Does that apply to patch 6 too?
