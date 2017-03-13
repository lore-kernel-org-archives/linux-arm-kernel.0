From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 13 Mar 2017 18:51:53 +0100
Subject: [PATCH] clocksource: add missing line break to error messages
In-Reply-To: <20170309094710.31003-1-zajec5@gmail.com>
References: <20170309094710.31003-1-zajec5@gmail.com>
Message-ID: <20170313175153.GC19679@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 10:47:10AM +0100, Rafa? Mi?ecki wrote:
[...]
> diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
> index f960891aa04e..b9990b9c98c5 100644
> --- a/drivers/clocksource/tegra20_timer.c
> +++ b/drivers/clocksource/tegra20_timer.c
> @@ -245,7 +245,7 @@ static int __init tegra20_init_rtc(struct device_node *np)
>  
>  	rtc_base = of_iomap(np, 0);
>  	if (!rtc_base) {
> -		pr_err("Can't map RTC registers");
> +		pr_err("Can't map RTC registers\n");
>  		return -ENXIO;
>  	}
>  

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170313/3dc1fe2c/attachment.sig>
