From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Jul 2018 08:33:49 +0100
Subject: [PATCH 3/5] mfd: axp20x: Support AXP806 in I2C mode
In-Reply-To: <20180620051540.25617-4-wens@csie.org>
References: <20180620051540.25617-1-wens@csie.org>
 <20180620051540.25617-4-wens@csie.org>
Message-ID: <20180704073349.GI20176@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jun 2018, Chen-Yu Tsai wrote:

> The Pine64 H64 board uses an AXP806 PMIC in I2C and self-working mode.
> The H64 SoC does not have the usual RSB controller.
> 
> This patch adds AXP806 to the list of devices supported in I2C mode.
> In theory, all RSB-based PMICs can also be used in I2C mode.
> 
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
