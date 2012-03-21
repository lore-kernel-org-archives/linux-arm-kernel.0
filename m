From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 21 Mar 2012 15:21:50 +0530
Subject: [RFC][PATCH 4/7] ARM: OMAP4: cpuidle - fix static omap4_idle_data
 declaration
In-Reply-To: <1332322070-24577-5-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <1332322070-24577-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F69A4B6.7030305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index 0455858..254f97b 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -33,7 +33,7 @@ struct omap4_idle_statedata {
>  
>  #define OMAP4_NUM_STATES 3
>  
> -struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
> +static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
OK

Regards
santosh
