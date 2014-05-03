From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 3 May 2014 19:17:54 -0400
Subject: [PATCH 1/2] misc: add sii9234 driver
In-Reply-To: <1397216910-15904-2-git-send-email-t.stanislaws@samsung.com>
References: <1397216910-15904-1-git-send-email-t.stanislaws@samsung.com>
 <1397216910-15904-2-git-send-email-t.stanislaws@samsung.com>
Message-ID: <20140503231754.GB20212@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 01:48:29PM +0200, Tomasz Stanislawski wrote:
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 1cb7408..3b7f266 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -515,6 +515,14 @@ config SRAM
>  	  the genalloc API. It is supposed to be used for small on-chip SRAM
>  	  areas found on many SoCs.
>  
> +config SII9234
> +	tristate "Silicon Image SII9234 Driver"
> +	depends on I2C

I doubt this is the only dependency, right?

thanks,

greg k-h
