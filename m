From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 27 Jan 2014 07:57:33 -0800
Subject: [PATCH v2 3/4] Update bcm_defconfig with new pinctrl CONFIG
In-Reply-To: <1390509887-19278-4-git-send-email-syin@broadcom.com>
References: <1390343886-25852-1-git-send-email-syin@broadcom.com>
 <1390509887-19278-1-git-send-email-syin@broadcom.com>
 <1390509887-19278-4-git-send-email-syin@broadcom.com>
Message-ID: <CAEPRUYp-VmSvdas2xW-pWQCX9Xn6PuFvoyRKz7s9v-MJfWh5TA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 12:44 PM, Sherman Yin <syin@broadcom.com> wrote:
> To be consistent with other Broadcom drivers, the Broadcom Capri pinctrl
> driver and its related CONFIG option are renamed to bcm281xx.
>
> This commit updates the defconfig that enables the pinctrl driver.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Matt Porter <mporter@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/configs/bcm_defconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index bede511..53d6d47 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -126,4 +126,4 @@ CONFIG_CRC_ITU_T=y
>  CONFIG_CRC7=y
>  CONFIG_XZ_DEC=y
>  CONFIG_AVERAGE=y
> -CONFIG_PINCTRL_CAPRI=y
> +CONFIG_PINCTRL_BCM281XX=y
> --
> 1.7.9.5
>

Acked-by: Christian Daudt <bcm@fixthebug.org>

Olof,
 Can you apply this patch directly or do you want me to send a pull
request with it ?

 Thanks,
   csd
