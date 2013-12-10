From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 9 Dec 2013 23:39:17 -0800
Subject: [RESEND PATCH] ARM: bcm_defconfig: Do not expect appended DTB
In-Reply-To: <1386286255-4338-1-git-send-email-tim.kryger@linaro.org>
References: <1386286255-4338-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYpQdS5yGEoYS0Yp16TL9Kj3hZr3tb16ZHzkWG+bW0Q4PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 3:30 PM, Tim Kryger <tim.kryger@linaro.org> wrote:
> The bootloaders used with Broadcom mobile SoCs are capable of handling
> a device tree separately from the zImage so there is no need for this
> option to be enabled.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>  arch/arm/configs/bcm_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 6e49310..b152367 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -35,7 +35,6 @@ CONFIG_AEABI=y
>  # CONFIG_COMPACTION is not set
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
> -CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_CMDLINE="console=ttyS0,115200n8 mem=128M"
>  CONFIG_CPU_IDLE=y
>  CONFIG_VFP=y
> --
> 1.8.0.1
>
Applied to armsoc/for-3.14/soc

 thanks,
  csd
