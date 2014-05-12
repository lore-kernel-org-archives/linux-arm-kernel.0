From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 May 2014 12:11:22 +0200
Subject: [PATCH Resend] defconfig: sama5_defconfig: updated
In-Reply-To: <1398137574-5790-1-git-send-email-wenyou.yang@atmel.com>
References: <1398137574-5790-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <53709E4A.9090301@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/2014 05:32, Wenyou Yang :
> due to enabling
> 	-- CONFIG_REGULATOR
> 	-- CONFIG_REGULATOR_ACT8865
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

With little modification: I didn't pushed these configuration options at
the end of the file but at their location: the one that is chosen while
running the "savedefconfig" make command.
This might avoid conflicts when adding more options to the
sama5_defconfig file.

I stack this modified one on top of our at91-3.16-cleanup2 branch.

thanks!

> ---
> Hi Nicolas,
> 
> It is a typo.
> This patch is based on the branch: at91-3.16-dt, not at91-3.10-dt of
> 	git://github.com/at91linux/linux-at91.git
> 
> Best Regards,
> Wenyou Yang
> 
>  arch/arm/configs/sama5_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index dc3881e..2b9891e 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -201,3 +201,5 @@ CONFIG_CRYPTO_DEV_ATMEL_TDES=y
>  CONFIG_CRYPTO_DEV_ATMEL_SHA=y
>  CONFIG_CRC_CCITT=m
>  CONFIG_CRC_ITU_T=m
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_ACT8865=y
> 


-- 
Nicolas Ferre
