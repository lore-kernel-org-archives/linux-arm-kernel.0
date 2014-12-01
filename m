From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 17:09:39 +0100
Subject: [PATCH 3/4] ARM: at91: remove at91sam9260/at91sam9g20 legacy
 board support
In-Reply-To: <1417434919.30245.31.camel@x220>
References: <cover.1416392687.git.nicolas.ferre@atmel.com>
 <4ea21d8c3309cde82c88eb6624cf2aaf08cb8bca.1416392687.git.nicolas.ferre@atmel.com>
 <1417434919.30245.31.camel@x220>
Message-ID: <5538141.cVWd2O2c59@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 12:55:19 Paul Bolle wrote:
> 
> There might be a problem with this patch. Or maybe it only needs some
> follow up cleanup. I noticed that when it landed in today's linux-next
> (ie, next-20141201) as commit b2026f708e09 ("ARM: at91: remove
> at91sam9260/at91sam9g20 legacy board support").

Good catch!

> The Kconfig symbol SND_AT91_SOC_AFEB9260 (see sound/soc/atmel/Kconfig)
> still depends on MACH_AFEB9260. So it can't be set anymore. Is that
> Kconfig symbol still needed or should it be removed too? Maybe a patch
> that fixes that is queued somewhere already.

I already found some other code that is now unused. I would guess that
this is in the same category, but the maintainers should comment if
they know better.

	Arnd
