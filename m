From: uboot@lukaperkov.net (Luka Perkov)
Date: Thu, 3 May 2012 13:21:15 +0200
Subject: [PATCH] gpio: Add simple poweroff-gpio driver
In-Reply-To: <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
References: <20120501195603.GW25584@lunn.ch>
 <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20120503112114.GA25484@w500.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On Thu, May 03, 2012 at 09:24:06AM +0100, Jamie Lentin wrote:
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -63,6 +63,16 @@ config GPIO_SYSFS
>  	  Kernel drivers may also request that a particular GPIO be
>  	  exported to userspace; this can be useful when debugging.
>  
> +config GPIO_POWEROFF
> +	tristate "GPIO power-off driver"
> +	depends on OF_GPIO
> +	help
> +	  This driver supports turning off your device via. a GPIO call.

Dot after via seems like a typo.

Other than this I have no comments.

Luka
