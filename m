From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Oct 2015 13:44:27 -0700
Subject: [PATCH v3 4/5] clk: sunxi: codec clock support
In-Reply-To: <1443512353-28073-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1443512353-28073-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443512353-28073-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151002204427.GZ12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29, Maxime Ripard wrote:
> diff --git a/drivers/clk/sunxi/clk-a10-codec.c b/drivers/clk/sunxi/clk-a10-codec.c
> new file mode 100644
> index 000000000000..aaeccf8cde39
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-a10-codec.c
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright 2013 Emilio L?pez
> + *
> + * Emilio L?pez <emilio@elopez.com.ar>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is this include used?

> +#include <linux/of.h>
> +#include <linux/of_address.h>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
