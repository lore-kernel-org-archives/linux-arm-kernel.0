From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Nov 2013 11:19:06 +0800
Subject: [PATCH 1/3] clk: imx5: introduce DT includes for clock provider
In-Reply-To: <1384369879-11878-2-git-send-email-l.stach@pengutronix.de>
References: <1384369879-11878-1-git-send-email-l.stach@pengutronix.de>
 <1384369879-11878-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20131114031902.GC17819@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 08:11:17PM +0100, Lucas Stach wrote:
<snip>

> +#define IMX5_CLK_SPDIF0_COM_SEL		181
> +#define IMX5_CLK_SPDIF1_COM_SEL		182
> +#define IMX5_CLK_SPDIF0_GATE		183
> +#define IMX5_CLK_SPDIF1_GATE		184
> +#define IMX5_CLK_SPDIF_IPG_GATE		185
> +#define IMX5_CLK_OCRAM			186
> +#define IMX5_SAHARA_IPG_GATE		187

s/IMX5_SAHARA_IPG_GATE/IMX5_CLK_SAHARA_IPG_GATE

> +#define IMX5_CLK_CLK_END		188

I know this is from include/dt-bindings/clock/imx6sl-clock.h.  Please
use IMX5_CLK_END to align with pattern used in vf610-clock.h.  I will
send a patch to change imx6sl-clock.h.

Shawn

> +
> +#endif /* __DT_BINDINGS_CLOCK_IMX5_H */
> -- 
> 1.8.4.2
> 
