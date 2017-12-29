From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 29 Dec 2017 14:47:19 +0100
Subject: [PATCH v2 1/5] ARM: sun9i: Support SMP on A80 with Multi-Cluster
 Power Management (MCPM)
In-Reply-To: <20171229105506.24851-2-mylene.josserand@free-electrons.com>
References: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
 <20171229105506.24851-2-mylene.josserand@free-electrons.com>
Message-ID: <CAOFm3uHmvHfGyd++8y6XnOQWMOA_jm5ur5WvPNdUF8SCzLr8dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Myl?ne, Chen-Yu,

On Fri, Dec 29, 2017 at 11:55 AM, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The A80 is a big.LITTLE SoC with 1 cluster of 4 Cortex-A7s and
> 1 cluster of 4 Cortex-A15s.

<snip>

> --- /dev/null
> +++ b/arch/arm/mach-sunxi/mcpm.c
> @@ -0,0 +1,391 @@
> +/*
> + * Copyright (c) 2015 Chen-Yu Tsai
> + *
> + * Chen-Yu Tsai <wens@csie.org>
> + *
> + * arch/arm/mach-sunxi/mcpm.c
> + *
> + * Based on arch/arm/mach-exynos/mcpm-exynos.c and Allwinner code
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

Would you mind using a concise SPDX tag instead, as documented by
Thomas doc patches?

Thank you for your kind consideration!
-- 
Cordially
Philippe Ombredanne
