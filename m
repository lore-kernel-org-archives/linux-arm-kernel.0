From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 12:37:50 -0500
Subject: [PATCH v2 08/13] dt-bindings: power: add RK3228 SoCs header for
 power-domain
In-Reply-To: <1526268668-20006-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
 <1526268668-20006-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20180522173750.GA17538@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 11:31:08AM +0800, Elaine Zhang wrote:
> According to a description from TRM, add all the power domains.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/power/rk3228-power.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3228-power.h
> 
> diff --git a/include/dt-bindings/power/rk3228-power.h b/include/dt-bindings/power/rk3228-power.h
> new file mode 100644
> index 000000000000..fa1264d5a995
> --- /dev/null
> +++ b/include/dt-bindings/power/rk3228-power.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

This goes on the first line. checkpatch.pl will tell you this.

The license here is different than all the others, was that the intent?

> + */
> +
> +#ifndef __DT_BINDINGS_POWER_RK3228_POWER_H__
> +#define __DT_BINDINGS_POWER_RK3228_POWER_H__
> +
> +/**
> + * RK3228 idle id Summary.
> + */
> +
> +#define RK3228_PD_CORE		0
> +#define RK3228_PD_MSCH		1
> +#define RK3228_PD_BUS		2
> +#define RK3228_PD_SYS		3
> +#define RK3228_PD_VIO		4
> +#define RK3228_PD_VOP		5
> +#define RK3228_PD_VPU		6
> +#define RK3228_PD_RKVDEC	7
> +#define RK3228_PD_GPU		8
> +#define RK3228_PD_PERI		9
> +#define RK3228_PD_GMAC		10
> +
> +#endif
> -- 
> 1.9.1
> 
> 
