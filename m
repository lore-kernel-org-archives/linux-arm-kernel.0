From: khilman@ti.com (Kevin Hilman)
Date: Mon, 09 Apr 2012 15:38:58 -0700
Subject: [PATCH 04/17][V2] ARM: OMAP4: cpuidle - fix static
 omap4_idle_data declaration
In-Reply-To: <1333570371-1389-5-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:38 +0200")
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
 <1333570371-1389-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87obr0a5tp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Missing changelog.

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index cdd7932..fb0f76e 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -33,7 +33,7 @@ struct omap4_idle_statedata {
>  
>  #define OMAP4_NUM_STATES 3
>  
> -struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
> +static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
>  static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
>  
>  /**
