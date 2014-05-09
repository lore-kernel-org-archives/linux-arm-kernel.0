From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 9 May 2014 14:52:51 +0100
Subject: [PATCH v3 3/7] mfd: add support for sun6i PRCM
 (Power/Reset/Clock Management) unit
In-Reply-To: <1399633911-7094-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1399633911-7094-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399633911-7094-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140509135251.GY5767@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The PRCM (Power/Reset/Clock Management) block exposes several subdevices
> in different subsystems (clk, reset ...)
> 
> Add basic support for the PRCM unit with clk (AR100, AHB0, and APB0 clks)
> and reset controller subdevices.
> 
> Other subdevices might be added later (if needed).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/mfd/Kconfig      |   8 +++
>  drivers/mfd/Makefile     |   1 +
>  drivers/mfd/sun6i-prcm.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 drivers/mfd/sun6i-prcm.c

[...]

> +/*
> + * Copyright (C) 2014 Free Electrons
> + *
> + * License Terms: GNU General Public License v2
> + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> + *
> + * Allwinner PRCM (Power/Reset/Clock Management) driver
> + *
> + */
> +
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

Ah, now isn't that better?

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
