From: eric@anholt.net (Eric Anholt)
Date: Thu, 12 May 2016 16:26:13 -0700
Subject: [PATCH 4/4] ARM: bcm2835: add thermal driver to default_config
In-Reply-To: <1463063738-11506-5-git-send-email-kernel@martin.sperl.org>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
 <1463063738-11506-5-git-send-email-kernel@martin.sperl.org>
Message-ID: <87lh3eamei.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add the thermal driver to list of compiled modules
> in the default config for bcm2835.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  arch/arm/configs/bcm2835_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index 29a44bd..634e07e 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -71,6 +71,8 @@ CONFIG_SPI_BCM2835=y
>  CONFIG_SPI_BCM2835AUX=y
>  CONFIG_GPIO_SYSFS=y
>  # CONFIG_HWMON is not set
> +CONFIG_THERMAL=y
> +CONFIG_BCM2835_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_BCM2835_WDT=y
>  CONFIG_FB=y
> -- 
> 2.1.4

It would be nice to see multi_v7_defconfig changed, too, since that's
what we expect people to be actually using

This patch is: Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160512/453aaf3a/attachment.sig>
