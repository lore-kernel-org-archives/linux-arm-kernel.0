From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 12:34:21 -0500
Subject: [PATCH v2 01/13] dt-bindings: power: add RK3036 SoCs header for
 power-domain
In-Reply-To: <1526268501-9200-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
 <1526268501-9200-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20180522173421.GA12892@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 11:28:21AM +0800, Elaine Zhang wrote:
> From: Caesar Wang <wxt@rock-chips.com>
> 
> According to a description from TRM, add all the power domains.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/power/rk3036-power.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3036-power.h
> 
> diff --git a/include/dt-bindings/power/rk3036-power.h b/include/dt-bindings/power/rk3036-power.h
> new file mode 100644
> index 000000000000..59e09f1c5af7
> --- /dev/null
> +++ b/include/dt-bindings/power/rk3036-power.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
> + * Author: Caesar Wang <wxt@rock-chips.com>
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

Use SPDX tag instead.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> + */
> +
> +#ifndef __DT_BINDINGS_POWER_RK3036_POWER_H__
> +#define __DT_BINDINGS_POWER_RK3036_POWER_H__
> +
> +#define RK3036_PD_MSCH		0
> +#define RK3036_PD_CORE		1
> +#define RK3036_PD_PERI		2
> +#define RK3036_PD_VIO		3
> +#define RK3036_PD_VPU		4
> +#define RK3036_PD_GPU		5
> +#define RK3036_PD_SYS		6
> +
> +#endif
> -- 
> 1.9.1
> 
> 
