From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Apr 2012 13:45:04 +0000
Subject: [PATCH 0/7]: arm: lpc32xx: Device tree support
In-Reply-To: <1333371364-21347-1-git-send-email-stigge@antcom.de>
References: <1333371364-21347-1-git-send-email-stigge@antcom.de>
Message-ID: <201204021345.04512.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Roland Stigge wrote:
> This is the first series of patches to introduce device tree support for the
> LPC32xx SoC. This series includes patches for the various subsystems to support
> device tree to be used later by the machine's initialization.
> 
> The patches apply to various subsystems:
> 
>  * staging/iio/adc
>  * rtc
>  * net
>  * arm-soc
>  * i2c
>  * wdt
> 
> Based on v3.4-rc1
> 
> You can also pull from
> 
>   git://git.antcom.de/linux-2.6 lpc32xx/dt
> 
> I'm CC'ing the various subsystem maintainers and lists who can each see what's
> going on and please pick their respective subsystem's changes. - Thanks!
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Looks good overall.

I notice that you are missing the bindings for irq and gpio, which tend to be
quite important. Do you have another tree that has all the lpc32xx specific
parts or are these still under heavy development?

Do you plan to add DT support in parallel to the ATAGS based board you
already have, or do you plan to move everything over quickly?
In the latter case, it might be helpful to get Acks from the subsystem
maintainers and merge everything through arm-soc.

	Arnd
