From: markus.mayer@linaro.org (Markus Mayer)
Date: Thu, 1 Aug 2013 10:43:02 -0700
Subject: [PATCH] ARM: configs: disable DEBUG_LL in bcm_defconfig
In-Reply-To: <1375377131-27445-1-git-send-email-matt.porter@linaro.org>
References: <1375377131-27445-1-git-send-email-matt.porter@linaro.org>
Message-ID: <CAPdLdq=PtqYy16sKkagKaOT=GRqD_OoDt9zBe19jRKmFUFkfDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2013 10:12, Matt Porter <matt.porter@linaro.org> wrote:
> DEBUG_LL is not supported yet on bcm281xx and causes a temporary
> hang due to timeout at boot.
>
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> ---
>  arch/arm/configs/bcm_defconfig |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 65edf6d..27a1b5f 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -112,7 +112,6 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=110
>  CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
>  CONFIG_DEBUG_INFO=y
>  # CONFIG_FTRACE is not set
> -CONFIG_DEBUG_LL=y
>  CONFIG_CRC_CCITT=y
>  CONFIG_CRC_T10DIF=y
>  CONFIG_CRC_ITU_T=y
> --
> 1.7.9.5

Reviewed-by: Markus Mayer <markus.mayer@linaro.org>

-- 
Markus Mayer
Broadcom Landing Team
