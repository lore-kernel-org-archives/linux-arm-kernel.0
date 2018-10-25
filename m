From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2018 11:24:16 +0100
Subject: [PATCH v5 11/11] mfd: axp20x: Add supported cells for AXP803
In-Reply-To: <20181023185330.10472-12-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-12-oskari@lemmela.net>
Message-ID: <20181025102416.GU4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018, Oskari Lemmela wrote:

> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> These include the GPIO, ADC, AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
