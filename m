From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jul 2011 20:43:06 +0900
Subject: [PATCH 0/6] clk: Initial feedback for off-SoC slow bus clocks
In-Reply-To: <20110711104625.GH26347@pengutronix.de>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<20110711093124.GA3239@n2100.arm.linux.org.uk>
	<20110711100759.GG26347@pengutronix.de>
	<20110711102856.GG3239@n2100.arm.linux.org.uk>
	<20110711104625.GH26347@pengutronix.de>
Message-ID: <20110711114304.GJ5092@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 12:46:25PM +0200, Sascha Hauer wrote:
> On Mon, Jul 11, 2011 at 11:28:56AM +0100, Russell King - ARM Linux wrote:

> > If that's all its for, then can't some other solution for debugfs names
> > (lets stop calling them clock names to avoid confusion) be found -
> > such as

> > 	sprintf(debugfsname, "%s@%p", clk->debugfsprefix, clk);

> Sounds good. During my tests on i.MX I found it very convenient to have
> speaking debugfs names, so I vote for this suggestion instead the
> following ones.

FWIW that's pretty much exactly what I added except I used a - instead
of @.
