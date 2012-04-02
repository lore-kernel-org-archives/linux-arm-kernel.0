From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Apr 2012 19:39:12 +0000
Subject: [PATCH v2 0/8]: arm: lpc32xx: Device tree support
In-Reply-To: <1333391587-26290-1-git-send-email-stigge@antcom.de>
References: <1333391587-26290-1-git-send-email-stigge@antcom.de>
Message-ID: <201204021939.12731.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Roland Stigge wrote:
> This is the first series of patches to introduce device tree support for the
> LPC32xx SoC. This series includes patches for the various subsystems to support
> device tree to be used later by the machine's initialization.
> 
> The patches apply to various subsystems:
> 
>  * staging/iio/adc (1)
>  * rtc (1)
>  * net (1)
>  * wdt (1)
>  * i2c (4)
>  * arm-soc (i2c related in the former, to be merged via i2c, as suggested by
>             Arnd Bergmann)

Looks good, please add

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

for the entire series.

	Arnd
