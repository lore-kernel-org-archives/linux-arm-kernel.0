From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 16:25:23 -0500
Subject: [PATCH v2 2/3] ARM: use clockevents_config_and_register()
 where possible
In-Reply-To: <1357991406-22778-3-git-send-email-shawn.guo@linaro.org>
References: <1357991406-22778-1-git-send-email-shawn.guo@linaro.org>
 <1357991406-22778-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130112212523.GD13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 07:50:05PM +0800, Shawn Guo wrote:
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Tested-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: David Brown <davidb@codeaurora.org>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Barry Song <baohua.song@csr.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Tony Prisk <linux@prisktech.co.nz>
> Cc: Lennert Buytenhek <buytenh@wantstofly.org>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
...
>  arch/arm/plat-orion/time.c               |    6 +-----
...

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
