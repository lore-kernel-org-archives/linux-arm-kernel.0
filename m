From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 May 2017 13:17:49 +0100
Subject: [PATCH v6 6/9] mfd: axp20x: add axp20x-regulator cell for AXP803
In-Reply-To: <20170518071653.36561-7-icenowy@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-7-icenowy@aosc.io>
Message-ID: <20170522121749.lqedysms2dywcyfl@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 May 2017, Icenowy Zheng wrote:

> As axp20x-regulator now supports AXP803, add a cell for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v5:
> - Removed wrong snippet.
> Changes in v4:
> - Added a trailing comma for new cell, for easier further cell addition.
> Changes in v3:
> - Make the new cell one-liner.
> 
>  drivers/mfd/axp20x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 1dc6235778eb..917b6ddc4f15 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -848,7 +848,8 @@ static struct mfd_cell axp803_cells[] = {
>  		.name			= "axp20x-pek",
>  		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>  		.resources		= axp803_pek_resources,
> -	}
> +	},
> +	{	.name			= "axp20x-regulator" },
>  };
>  
>  static struct mfd_cell axp806_cells[] = {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
