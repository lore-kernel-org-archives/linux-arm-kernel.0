From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 9 Oct 2015 00:37:46 -0700
Subject: [PATCH 02/10] clk: nsp: add clock support for Broadcom Northstar
 Plus SoC
In-Reply-To: <1443826665-17570-3-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-3-git-send-email-jonmason@broadcom.com>
Message-ID: <20151009073746.GP26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02, Jon Mason wrote:
> diff --git a/drivers/clk/bcm/clk-nsp.c b/drivers/clk/bcm/clk-nsp.c
> new file mode 100644
> index 0000000..708961a
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-nsp.c
> @@ -0,0 +1,139 @@
> +/*
> + * Copyright (C) 2015 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/clkdev.h>

Is this used?

> +#include <linux/of_address.h>
> +#include <linux/delay.h>

Is this used?

> +
> +#include <dt-bindings/clock/bcm-nsp.h>
> +#include "clk-iproc.h"

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
