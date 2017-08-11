From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Aug 2017 10:47:09 +0530
Subject: [PATCH 4/4] cpufreq: dbx500: Delete obsolete driver
In-Reply-To: <20170810125221.25818-5-linus.walleij@linaro.org>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-5-linus.walleij@linaro.org>
Message-ID: <20170811051709.GE3638@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-08-17, 14:52, Linus Walleij wrote:
> We have moved the Ux500 over to use the generic DT based
> cpufreq driver, so delete the old custom driver.
> 
> At the same time select CPUFREQ_DT from the machine's
> Kconfig in order to satisfy the "default ARCH_U8500"
> selection on the old driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/Kconfig      |   1 +
>  drivers/cpufreq/Kconfig.arm      |   9 ----
>  drivers/cpufreq/Makefile         |   1 -
>  drivers/cpufreq/dbx500-cpufreq.c | 103 ---------------------------------------
>  4 files changed, 1 insertion(+), 113 deletions(-)
>  delete mode 100644 drivers/cpufreq/dbx500-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
