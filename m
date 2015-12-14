From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Dec 2015 09:38:45 +0800
Subject: [PATCH V4 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <1449890833-7195-1-git-send-email-marex@denx.de>
References: <20151211110700.GD11252@tiger>
 <1449890833-7195-1-git-send-email-marex@denx.de>
Message-ID: <20151214013845.GP11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2015 at 04:27:13AM +0100, Marek Vasut wrote:
> From: Sean Cross <xobs@kosagi.com>
> 
> Novena is an open-hardware laptop/desktop/bare board.
> 
> See http://www.kosagi.com/w/index.php?title=Novena_Main_Page
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawnguo@kernel.org>

It looks pretty good to me now, except a small question below.

> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/imx6q-novena.dts | 789 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 790 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-novena.dts

<snip>

> +/ {
> +	model = "Kosagi Novena Dual/Quad";
> +	compatible = "kosagi,imx6q-novena", "fsl,imx6q";
> +
> +	memory {
> +		reg = <0x10000000 0xefffffff>;

What's the trick of having memory size being 0xefffffff?

Shawn

> +	};
>  
