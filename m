From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 17 Feb 2017 17:54:59 +0000
Subject: [PATCH] arm64: kernel: Update kerneldoc for cpu_suspend() rename
In-Reply-To: <1487341508-20148-1-git-send-email-geert+renesas@glider.be>
References: <1487341508-20148-1-git-send-email-geert+renesas@glider.be>
Message-ID: <58b72e17-7578-b7e3-b244-b034ef1d809c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/02/17 14:25, Geert Uytterhoeven wrote:
> Commit af391b15f7b56ce1 ("arm64: kernel: rename __cpu_suspend to keep it
> aligned with arm") renamed cpu_suspend() to arm_cpuidle_suspend(), but
> forgot to update the kerneldoc header.
> 
> Fixes: af391b15f7b56ce1 ("arm64: kernel: rename __cpu_suspend to keep it aligned with arm")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/kernel/cpuidle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> index 75a0f8acef669ce5..fd691087dc9ad58f 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -30,7 +30,7 @@ int arm_cpuidle_init(unsigned int cpu)
>  }
>  
>  /**
> - * cpu_suspend() - function to enter a low-power idle state
> + * arm_cpuidle_suspend() - function to enter a low-power idle state

Sorry for that. Looks good to me.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
