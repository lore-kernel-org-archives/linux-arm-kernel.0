From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 10 Sep 2013 16:06:37 +0300
Subject: [PATCH 1/8] ARM: plat-iop: move the GPIO driver to drivers/gpio
In-Reply-To: <1378741211-12884-1-git-send-email-linus.walleij@linaro.org>
References: <1378741211-12884-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130910130637.GC3379@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 09, 2013 at 05:40:11PM +0200, Linus Walleij wrote:
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -312,6 +312,15 @@ config GPIO_ICH
>  
>  	  If unsure, say N.
>  
> +config GPIO_IOP
> +	tristate "Intel ICH GPIO"
                        ^^^

This should probably say IOP.

A.
