From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 20:32:53 +0200
Subject: [PATCH] ARM: s3c64xx: Select CPU_V6K instead of CPU_V6
In-Reply-To: <1380390554-4400-1-git-send-email-tomasz.figa@gmail.com>
References: <1380390554-4400-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <3346618.t8I6lVv536@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Saturday 28 of September 2013 19:49:14 Tomasz Figa wrote:
> All S3C64XX SoCs come with ARM1176JZF-s core, which fully supports
> ARMv6K extensions. This patch lets the kernel use them on S3C6410 by
> adding selection of CPU_V6K to ARCH_S3C64XX.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What do you think about this patch?

Best regards,
Tomasz

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b766dad..3a41bbb 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -728,7 +728,7 @@ config ARCH_S3C64XX
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_SAMSUNG_PWM
>  	select COMMON_CLK
> -	select CPU_V6
> +	select CPU_V6K
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_SAMSUNG
>  	select HAVE_CLK
