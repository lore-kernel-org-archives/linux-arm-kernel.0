From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 01 May 2014 08:43:07 +0200
Subject: [PATCH v2 01/12] ARM: imx/mxs defconfigs: add MTD_SPI_NOR (new
 dependency for M25P80)
In-Reply-To: <1398925607-7482-2-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
 <1398925607-7482-2-git-send-email-computersforpeace@gmail.com>
Message-ID: <1398926587.28080.5.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-30 at 23:26 -0700, Brian Norris wrote:
> These defconfigs contain the CONFIG_M25P80 symbol, which is now

That's a typo: use "the MTD_M25P80 symbol" (but only if you need to
resend anyway, I'd say; the same typo can be found in the subject too).

> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to satisfy
> the new dependency.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Reviewed-by: Marek Vasut <marex@denx.de>


Paul Bolle
