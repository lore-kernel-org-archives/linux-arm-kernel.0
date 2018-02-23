From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 23 Feb 2018 12:05:02 +0800
Subject: [PATCH v2 1/4] dt-bindings: add binding for i.MX8MQ CCM
In-Reply-To: <20180201175412.9480-1-l.stach@pengutronix.de>
References: <20180201175412.9480-1-l.stach@pengutronix.de>
Message-ID: <20180223040500.GN3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 06:54:09PM +0100, Lucas Stach wrote:
> +/* ENET AXI */
> +#define IMX8MQ_CLK_ENET_AXI_SRC		107
> +#define IMX8MQ_CLK_ENET_AXI_CG		108
> +#define IMX8MQ_CLK_ENET_AXI_PRE_DIV	109
> +#define IMX8MQ_CLK_ENET_AXI_DIV		110

The indentation changes from here.  Since these defines are added in one
time, the indentation can be unified.

Shawn

> +/* NAND_USDHC_BUS */
> +#define IMX8MQ_CLK_NAND_USDHC_BUS_SRC		111
> +#define IMX8MQ_CLK_NAND_USDHC_BUS_CG		112
> +#define IMX8MQ_CLK_NAND_USDHC_BUS_PRE_DIV	113
> +#define IMX8MQ_CLK_NAND_USDHC_BUS_DIV		114
