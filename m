From: xuwei04@gmail.com (Xu Wei)
Date: Mon, 18 Apr 2016 16:14:53 +0100
Subject: [PATCH v2 RESEND 2/4] arm64: Kconfig: select sp804 timer for
 ARCH_HISI
In-Reply-To: <1453373630-4693-3-git-send-email-leo.yan@linaro.org>
References: <1453373630-4693-1-git-send-email-leo.yan@linaro.org>
 <1453373630-4693-3-git-send-email-leo.yan@linaro.org>
Message-ID: <5714F9ED.3020907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On 21/01/16 10:53, Leo Yan wrote:
> Select sp804 timer for ARCH_HISI, which is used as broadcast timer.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   arch/arm64/Kconfig.platforms | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 4043c35..94c410d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -36,6 +36,7 @@ config ARCH_LAYERSCAPE
>   
>   config ARCH_HISI
>   	bool "Hisilicon SoC Family"
> +	select ARM_TIMER_SP804
>   	help
>   	  This enables support for Hisilicon ARMv8 SoC family
>   
Just applied this to the hisilicon soc tree.
The others have been picked up from Guodong's patch set.
Thanks!

Best Regards,
Wei
