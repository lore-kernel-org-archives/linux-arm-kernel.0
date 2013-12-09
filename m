From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 9 Dec 2013 08:17:21 -0800
Subject: [PATCH 1/2] ARM: bcm_defconfig: CONFIG_OABI_COMPAT default off
In-Reply-To: <1386284438-11099-2-git-send-email-tim.kryger@linaro.org>
References: <1386284438-11099-1-git-send-email-tim.kryger@linaro.org>
 <1386284438-11099-2-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYr3u6z+6CKf+u+hEMo+D4Nz=P43zKJGBJy=ZDVyNBBt4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 3:00 PM, Tim Kryger <tim.kryger@linaro.org> wrote:
> Now that CONFIG_OABI_COMPAT is off by default, remove the explicit
> disabling of this feature.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>  arch/arm/configs/bcm_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 287ac1d..574e046 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -29,7 +29,6 @@ CONFIG_ARCH_BCM_MOBILE=y
>  CONFIG_ARM_THUMBEE=y
>  CONFIG_PREEMPT=y
>  CONFIG_AEABI=y
> -# CONFIG_OABI_COMPAT is not set
>  # CONFIG_COMPACTION is not set
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
> --
> 1.8.0.1
>
Applied to armsoc/for-3.14/soc

 thanks,
   csd
