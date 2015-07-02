From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 14:54:48 -0700
Subject: [PATCH v2 8/9] clk: rockchip: add dt-binding header for rk3368
In-Reply-To: <1434637116-17124-9-git-send-email-heiko@sntech.de>
References: <1434637116-17124-1-git-send-email-heiko@sntech.de>
 <1434637116-17124-9-git-send-email-heiko@sntech.de>
Message-ID: <20150702215448.GJ4301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Heiko Stuebner wrote:
> diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings/clock/rk3368-cru.h
> new file mode 100644
> index 0000000..6280753
> --- /dev/null
> +++ b/include/dt-bindings/clock/rk3368-cru.h
> @@ -0,0 +1,379 @@
> +/*
> + * Copyright (c) 2015 Heiko Stuebner <heiko@sntech.de>
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

Add some include guards?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
