From: marex@denx.de (Marek Vasut)
Date: Tue, 19 Jun 2012 23:13:07 +0200
Subject: [PATCH] clk: mxs: Fix the GPMI clock name
In-Reply-To: <1340137652-2227-1-git-send-email-festevam@gmail.com>
References: <1340137652-2227-1-git-send-email-festevam@gmail.com>
Message-ID: <201206192313.07458.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The correct name for the GPMI clock is 'gpmi-nand'.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/clk/mxs/clk-imx23.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
> index f7be225..40ad638 100644
> --- a/drivers/clk/mxs/clk-imx23.c
> +++ b/drivers/clk/mxs/clk-imx23.c
> @@ -106,7 +106,7 @@ static struct clk_lookup lcdif_lookups[] __initdata = {
> 
>  static struct clk_lookup gpmi_lookups[] __initdata = {
>  	{ .dev_id = "imx23-gpmi-nand", },
> -	{ .dev_id = "8000c000.gpmi", },
> +	{ .dev_id = "8000c000.gpmi-nand", },
>  };
> 
>  static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };

Best regards,
Marek Vasut
