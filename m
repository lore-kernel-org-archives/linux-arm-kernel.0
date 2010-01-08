From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 16:49:34 +0000
Subject: [PATCH] ARM: Add atomic64 routines for ARMv6k and above.
In-Reply-To: <20091215131626.GA31026@pengutronix.de>
References: <20091215082424.GB20571@pengutronix.de>
	<1260872214.1569.11.camel@pc1117.cambridge.arm.com>
	<20091215131626.GA31026@pengutronix.de>
Message-ID: <20100108164934.GG32558@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2009 at 02:16:26PM +0100, Uwe Kleine-K?nig wrote:
> Maybe we should make that explicit somehow?  E.g. let CPU_32v6K depend
> on !CPU_32v5?  (I didn't check the symbol names.)

Doesn't work, select overrides dependencies.
