From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 12 Jul 2018 13:30:38 +0100
Subject: [PATCH v2 3/5] mfd: axp20x: Support AXP806 in I2C mode
In-Reply-To: <20180705031106.344-4-wens@csie.org>
References: <20180705031106.344-1-wens@csie.org>
 <20180705031106.344-4-wens@csie.org>
Message-ID: <20180712123038.GH4641@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 05 Jul 2018, Chen-Yu Tsai wrote:

> The Pine64 H64 board uses an AXP806 PMIC in I2C and self-working mode.
> The H64 SoC does not have the usual RSB controller.
> 
> This patch adds AXP806 to the list of devices supported in I2C mode.
> In theory, all RSB-based PMICs can also be used in I2C mode.
> 
> Reviewed-by: Icenowy Zheng <icenowy@aosc.io>
> Tested-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
