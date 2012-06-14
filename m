From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jun 2012 11:04:25 +0100
Subject: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
In-Reply-To: <20120613221040.GJ30400@pengutronix.de>
References: <20120522234621.GA3610@windriver.com>
 <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
 <20120613221040.GJ30400@pengutronix.de>
Message-ID: <20120614100425.GC28714@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 12:10:40AM +0200, Sascha Hauer wrote:
> As the netx does not have fb support in mainline you can just drop this
> one aswell. It has no use.

Are you sure?

Grepping for clcd in arch/arm/mach-netx shows that nxdb500 and nxeb500hmi
seem to have all the necessary stuff to support the AMBA CLCD driver.
