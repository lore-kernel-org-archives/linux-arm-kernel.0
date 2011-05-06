From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 6 May 2011 11:01:34 +0300
Subject: [PATCH] leds: drop leds-h1940 driver
In-Reply-To: <00f701cc0ba4$3cb4b680$b61e2380$%kim@samsung.com>
References: <1303912597-32653-1-git-send-email-anarsoul@gmail.com>
	<00f701cc0ba4$3cb4b680$b61e2380$%kim@samsung.com>
Message-ID: <201105061101.34589.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 May 2011 07:15:27 Kukjin Kim wrote:
> Hi Vasily,

Hi
 
> Hmm, regarding maintainer who is Richard Purdie(LED) in this case should be
> added in Cc. (Cc'ed him)

Sorry, forgot to add him to CC :(

> And I think need following with this patch.
> 
> --- a/arch/arm/configs/s3c2410_defconfig
> +++ b/arch/arm/configs/s3c2410_defconfig
> @@ -389,7 +389,6 @@ CONFIG_MMC_SPI=m
>  CONFIG_MMC_S3C=y
>  CONFIG_LEDS_CLASS=m
>  CONFIG_LEDS_S3C24XX=m
> -CONFIG_LEDS_H1940=m
>  CONFIG_LEDS_PCA9532=m
>  CONFIG_LEDS_GPIO=m
>  CONFIG_LEDS_PCA955X=m

Sure. Can you commit this change to your tree, or should I resend patch with 
this change?

Regards
Vasily
