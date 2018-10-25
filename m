From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2018 11:23:24 +0100
Subject: [PATCH v5 09/11] power: supply: add AC power supply driver for
 AXP813
In-Reply-To: <20181023185330.10472-10-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-10-oskari@lemmela.net>
Message-ID: <20181025102324.GS4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018, Oskari Lemmela wrote:

> AXP813 and AXP803 PMICs can control input current and minimum voltage.
> 
> Both of these values are configurable.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 94 ++++++++++++++++++++++++++

>  include/linux/mfd/axp20x.h             |  1 +

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
