From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 May 2015 00:23:02 -0700
Subject: [PATCH 2/2] clk: mmp: add PXA1928 clock support
In-Reply-To: <1430455271-20195-2-git-send-email-robh@kernel.org>
References: <1430455271-20195-1-git-send-email-robh@kernel.org>
 <1430455271-20195-2-git-send-email-robh@kernel.org>
Message-ID: <20150506072302.GE27050@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30, Rob Herring wrote:
> diff --git a/drivers/clk/mmp/clk-of-pxa1928.c b/drivers/clk/mmp/clk-of-pxa1928.c
> new file mode 100644
> index 0000000..b7cb540b
> --- /dev/null
> +++ b/drivers/clk/mmp/clk-of-pxa1928.c
> @@ -0,0 +1,265 @@
> +/*
> + * pxa1928 clock framework source file
> + *
> + * Copyright (C) 2015 Linaro, Ltd.
> + * Rob Herring <robh@kernel.org>
> + *
> + * Based on drivers/clk/mmp/clk-of-mmp2.c:
> + * Copyright (C) 2012 Marvell
> + * Chao Xie <xiechao.mail@gmail.com>
> + *

Any reason to leave Chao off Cc?

> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/module.h>

This include is unused?

> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>

#include <linux/slab.h> ?

> +
> +#include <dt-bindings/clock/marvell,pxa1928.h>
> +

Otherwise looks ok to me.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
