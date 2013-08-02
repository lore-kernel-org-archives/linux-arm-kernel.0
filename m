From: csd@broadcom.com (Christian Daudt)
Date: Fri, 2 Aug 2013 16:58:09 -0700
Subject: [PATCH] ARM: configs: disable DEBUG_LL in bcm_defconfig
In-Reply-To: <1375377131-27445-1-git-send-email-matt.porter@linaro.org>
References: <1375377131-27445-1-git-send-email-matt.porter@linaro.org>
Message-ID: <51FC4791.3030607@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-01 10:12 AM, Matt Porter wrote:
> DEBUG_LL is not supported yet on bcm281xx and causes a temporary
> hang due to timeout at boot.
>
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> ---
>   arch/arm/configs/bcm_defconfig |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 65edf6d..27a1b5f 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -112,7 +112,6 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=110
>   CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
>   CONFIG_DEBUG_INFO=y
>   # CONFIG_FTRACE is not set
> -CONFIG_DEBUG_LL=y
>   CONFIG_CRC_CCITT=y
>   CONFIG_CRC_T10DIF=y
>   CONFIG_CRC_ITU_T=y
Reviewed-by: Christian Daudt <csd@broadcom.com>

Applied to for-3.12/soc

  thanks,
    csd
