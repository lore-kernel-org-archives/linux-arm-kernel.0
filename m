From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2011 23:33:26 +0200
Subject: [PATCH] mach-integrator: delete bits.h include file
In-Reply-To: <20110711094236.GC3239@n2100.arm.linux.org.uk>
References: <1310377091-18103-1-git-send-email-linus.walleij@linaro.org>
	<20110711094236.GC3239@n2100.arm.linux.org.uk>
Message-ID: <201107112333.26596.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 July 2011, Russell King - ARM Linux wrote:
> On Mon, Jul 11, 2011 at 11:38:11AM +0200, Linus Walleij wrote:
> > Not only does this file duplicate <linux/bitops.h> and implement a
> > well-known antipattern, it is also not used by anything.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied to arm-soc/next/cleanup

Thanks,

	Arnd
