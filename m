From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 25 Mar 2013 10:08:32 +0900
Subject: [PATCH] ARM: SAMSUNG: Remove useless Samsung GPIO related CONFIG
In-Reply-To: <1363865141.1390.120.camel@x61.thuisdomein>
References: <1363865141.1390.120.camel@x61.thuisdomein>
Message-ID: <16e101ce28f5$44aead80$ce0c0880$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle wrote:
> 
> The Kconfig entry for S3C_GPIO_CFG_S3C64XX was missed by commit
> 5ec7414494ed1204c9e2ed0b8232b29860d0986f ("ARM: SAMSUNG: Remove useless
> Samsung GPIO related CONFIGs"). Remove it now.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
>  arch/arm/plat-samsung/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 663c54f..91c2d72 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -117,12 +117,6 @@ config SAMSUNG_GPIOLIB_4BIT
>  	  configuration. GPIOlib shall be compiled only for S3C64XX and S5P
>  	  series of processors.
> 
> -config S3C_GPIO_CFG_S3C64XX
> -	bool
> -	help
> -	  Internal configuration to enable S3C64XX style GPIO configuration
> -	  functions.
> -
>  config S5P_GPIO_DRVSTR
>  	bool
>  	help
> --
> 1.7.11.7

Applied, thanks.

- Kukjin
