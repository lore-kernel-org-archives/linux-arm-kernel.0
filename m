From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 08:53:16 +0100
Subject: [PATCH 08/13] clocksource: convert ARM 32-bit down counting
	clocksources
In-Reply-To: <alpine.LFD.2.00.1105100838530.15037@xanadu.home>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1105100838530.15037@xanadu.home>
Message-ID: <20110511075316.GC15120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 08:39:58AM -0400, Nicolas Pitre wrote:
> On Tue, 10 May 2011, Russell King - ARM Linux wrote:
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
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

Does that apply to patch 6 too?
