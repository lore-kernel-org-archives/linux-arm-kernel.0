From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 08:52:46 +0100
Subject: [PATCH 07/13] clocksource: convert ARM 32-bit up counting
	clocksources
In-Reply-To: <BANLkTikqsxBs90+zk36MGj=3ekmfFpEZdA@mail.gmail.com>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNy-0000yl-V0@rmk-PC.arm.linux.org.uk>
	<BANLkTikqsxBs90+zk36MGj=3ekmfFpEZdA@mail.gmail.com>
Message-ID: <20110511075246.GA15120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 11:10:08PM +0200, Linus Walleij wrote:
> 2011/5/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > Convert ixp4xx, lpc32xx, mxc, netx, pxa, sa1100, tcc8k, tegra and u300
> > to use the generic mmio clocksource recently introduced.
> >
> > Cc: Imre Kaloz <kaloz@openwrt.org>
> > Cc: Krzysztof Halasa <khc@pm.waw.pl>
> > Cc: Eric Miao <eric.y.miao@gmail.com>
> > Cc: "Hans J. Koch" <hjk@hansjkoch.de>
> > Cc: Colin Cross <ccross@android.com>
> > Cc: Erik Gilling <konkers@android.com>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Does that apply to patch 6 too?
