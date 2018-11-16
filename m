From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Nov 2018 10:59:39 +0800
Subject: [PATCH] ASoC: imx-audmux: complete dt-bindings for imx6
In-Reply-To: <20181105135802.30486-1-peron.clem@gmail.com>
References: <20181105135802.30486-1-peron.clem@gmail.com>
Message-ID: <20181116025938.GH5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 02:58:02PM +0100, Cl?ment P?ron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> The MX6 Audmux differs from MX51.
> 
> This patch adds the audmux for i.MX6 family.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>

I think you should send it to ASoC maintainer and list for applying.

Shawn

> ---
>  include/dt-bindings/sound/fsl-imx-audmux.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
> index 15f138bebe16..a1d0741d9ed1 100644
> --- a/include/dt-bindings/sound/fsl-imx-audmux.h
> +++ b/include/dt-bindings/sound/fsl-imx-audmux.h
> @@ -25,6 +25,14 @@
>  #define MX51_AUDMUX_PORT6		5
>  #define MX51_AUDMUX_PORT7		6
>  
> +#define MX6_AUDMUX_PORT1_SSI1		0
> +#define MX6_AUDMUX_PORT2_SSI2		1
> +#define MX6_AUDMUX_PORT3		2
> +#define MX6_AUDMUX_PORT4		3
> +#define MX6_AUDMUX_PORT5		4
> +#define MX6_AUDMUX_PORT6		5
> +#define MX6_AUDMUX_PORT7_SSI3		6
> +
>  /*
>   * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
>   * can be sourced from Rx/Tx.
> -- 
> 2.19.1
> 
