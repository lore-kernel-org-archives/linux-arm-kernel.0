From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 31 May 2018 11:36:20 +0300
Subject: [PATCH v4 4/5] clocksource: add driver for i.MX EPIT timer
In-Reply-To: <20180530120327.27681-5-peron.clem@gmail.com>
References: <20180530120327.27681-1-peron.clem@gmail.com>
 <20180530120327.27681-5-peron.clem@gmail.com>
Message-ID: <677be207-67be-ccbc-8bb3-ab90bf9d05a7@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cl?ment,

On 05/30/2018 03:03 PM, Cl?ment P?ron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add driver for NXP's EPIT timer used in i.MX 6 family of SoC.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> ---

[snip]

> +++ b/drivers/clocksource/timer-imx-epit.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * i.MX EPIT Timer
> + *
> + * Copyright (C) 2010 Sascha Hauer <s.hauer@pengutronix.de>
> + * Copyright (C) 2018 Colin Didier <colin.didier@devialet.com>
> + * Copyright (C) 2018 Cl?ment P?ron <clement.peron@devialet.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/err.h>

The included header above still can be removed.

I have no more comments about the code, I will try to find time to
test the driver, but please don't take it as a promise.

--
With best wishes,
Vladimir
