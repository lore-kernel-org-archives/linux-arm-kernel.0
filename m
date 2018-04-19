From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 19 Apr 2018 09:43:42 +0530
Subject: [PATCH 1/2] cpufreq: brcmstb-avs-cpufreq: remove development
 debug support
In-Reply-To: <20180418155643.36464-2-code@mmayer.net>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-2-code@mmayer.net>
Message-ID: <20180419041342.GE24576@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-04-18, 08:56, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> This debug code was helpful while developing the driver, but it isn't
> being used for anything anymore.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig.arm           |  10 --
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 323 +---------------------------------
>  2 files changed, 1 insertion(+), 332 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
