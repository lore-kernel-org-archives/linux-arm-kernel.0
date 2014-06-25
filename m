From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Jun 2014 17:52:35 -0700
Subject: [RFC/PATCH 10/12] cpufreq: Add a cpufreq-krait based on
 cpufreq-cpu0
In-Reply-To: <1403654783-7176-11-git-send-email-sboyd@codeaurora.org>
References: <1403654783-7176-1-git-send-email-sboyd@codeaurora.org>
 <1403654783-7176-11-git-send-email-sboyd@codeaurora.org>
Message-ID: <53AA1D53.3050207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/14 17:06, Stephen Boyd wrote:
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 738c8b7b17dc..f5c9f68dcc0f 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
>  obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
>  
>  obj-$(CONFIG_GENERIC_CPUFREQ_CPU0)	+= cpufreq-cpu0.o
> +obj-$(CONFIG_CPUFREQ_KRAIT)		+= cpufreq-krait.o
>

Hmph, last minute name changes are bad. This should be
CONFIG_GENERIC_CPUFREQ_KRAIT.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
