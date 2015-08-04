From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 04 Aug 2015 10:54:06 +0200
Subject: [PATCH v3 1/2] clk: rockchip: add pclk_pd_pmu to the list of
 rk3288 critical clocks
In-Reply-To: <1438670487-27598-1-git-send-email-hl@rock-chips.com>
References: <1438670487-27598-1-git-send-email-hl@rock-chips.com>
Message-ID: <1588782.u2WKR6eVuV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 4. August 2015, 14:41:26 schrieb Lin Huang:

I guess this patch then would need a

From: Heiko Stuebner <heiko@sntech.de>

at this point to override the author then.


> pclk_pd_pmu needs to keep running and with the upcoming gpio clock
> handling this is not always the case anymore. So add it to the list
> of critical clocks for now.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v3:
> -match the author and Signed-off-by name
> 
>  drivers/clk/rockchip/clk-rk3288.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c
> b/drivers/clk/rockchip/clk-rk3288.c index 0df5bae..9040878 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -780,6 +780,7 @@ static const char *const rk3288_critical_clocks[]
> __initconst = { "aclk_cpu",
>  	"aclk_peri",
>  	"hclk_peri",
> +	"pclk_pd_pmu",
>  };
> 
>  #ifdef CONFIG_PM_SLEEP
