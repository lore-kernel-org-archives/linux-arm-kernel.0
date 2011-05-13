From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 May 2011 15:30:14 +0100
Subject: [PATCH 08/13 v2] clocksource: convert ARM 32-bit down counting
	clocksources
In-Reply-To: <20110512124710.GE1356@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
	<20110512124710.GE1356@n2100.arm.linux.org.uk>
Message-ID: <1305297014.31204.113.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-12 at 13:47 +0100, Russell King - ARM Linux wrote:
> Convert SP804, MXC, Nomadik and Orion 32-bit down-counting clocksources
> to generic mmio clocksource infrastructure.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
...
> diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
> index 6ef3342..445b05e 100644
> --- a/arch/arm/common/timer-sp.c
> +++ b/arch/arm/common/timer-sp.c

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
