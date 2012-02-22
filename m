From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 14:26:00 +0000
Subject: [PATCH v5] ARM: LPC32xx: ADC support for mach-lpc32xx
In-Reply-To: <1329487094-3486-1-git-send-email-stigge@antcom.de>
References: <1329487094-3486-1-git-send-email-stigge@antcom.de>
Message-ID: <201202221426.00620.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 February 2012, Roland Stigge wrote:
> This patch adds the mach specific support for the LPC32XX ADC driver (the
> latter being already in staging/iio)
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> ---
>  Olof, can you please add this to the updated LPC32xx support? The patch
>  applies cleanly to current arm-soc.git/for-next. The actual ADC driver that is
>  used here was already accepted to staging/iio by GregKH.

Pulled into the next/drivers branch.

Because of the way we work with topic branches, it's easier if you
submit patches that apply cleanly to an -rc release. I ended up doing
the trivial backport of the patch and then resolving the trivial
merge conflict with the bugfix we got earlier.

	Arnd
