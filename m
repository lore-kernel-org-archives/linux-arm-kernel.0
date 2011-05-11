From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 08:52:58 +0100
Subject: [PATCH 07/13] clocksource: convert ARM 32-bit up counting
	clocksources
In-Reply-To: <20110511001653.GA7602@local>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNy-0000yl-V0@rmk-PC.arm.linux.org.uk>
	<20110511001653.GA7602@local>
Message-ID: <20110511075258.GB15120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 02:16:53AM +0200, Hans J. Koch wrote:
> On Tue, May 10, 2011 at 08:29:38AM +0100, Russell King - ARM Linux wrote:
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
> Acked-by: "Hans J. Koch" <hjk@hansjkoch.de>

Does that apply to patch 6 too?
