From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 16 Jan 2017 15:38:48 +0100
Subject: [PATCH v2 2/3] MAINTAINERS: add zx2967 reset controller driver
 to ARM ZTE architecture
In-Reply-To: <1484564194-18530-2-git-send-email-baoyou.xie@linaro.org>
References: <1484564194-18530-1-git-send-email-baoyou.xie@linaro.org>
 <1484564194-18530-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1484577528.8415.147.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-16 at 18:56 +0800, Baoyou Xie wrote:
> Add the zx2967 reset controller driver as maintained by ARM ZTE
> architecture maintainers, as they're parts of the core IP.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2793808..08f8155 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1980,10 +1980,12 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/mach-zx/
>  F:	drivers/clk/zte/
> +F:	drivers/reset/reset-zx2967.c
>  F:	drivers/soc/zte/
>  F:	drivers/thermal/zx*
>  F:	Documentation/devicetree/bindings/arm/zte.txt
>  F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
> +F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
>  F:	Documentation/devicetree/bindings/soc/zte/
>  F:	Documentation/devicetree/bindings/thermal/zx*
>  F:	include/dt-bindings/soc/zx*.h

This patch doesn't apply on top of reset/next. I can rebase it, but it
will cause a trivial merge conflict with the soc/thermal additions.

regards
Philipp
