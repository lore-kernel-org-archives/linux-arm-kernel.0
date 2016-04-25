From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 25 Apr 2016 15:22:33 +0530
Subject: [PATCH 4/4] ARM: remove duplicate const qualifier
In-Reply-To: <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
Message-ID: <20160425095233.GH32183@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-04-16, 10:47, Eric Engestrom wrote:
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index 9ccffc1..aaaa678 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -204,7 +204,7 @@ static void __init spear_clockevent_init(int irq)
>  	setup_irq(irq, &spear_timer_irq);
>  }
>  
> -static const struct of_device_id const timer_of_match[] __initconst = {
> +static const struct of_device_id timer_of_match[] __initconst = {
>  	{ .compatible = "st,spear-timer", },
>  	{ },
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
