From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 12:39:12 -0500
Subject: [PATCH v2 11/13] dt-bindings: power: add PX30 SoCs header for
 power-domain
In-Reply-To: <1526268724-25288-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
 <1526268724-25288-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20180522173912.GA19562@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 11:32:04AM +0800, Elaine Zhang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> According to a description from TRM, add all the power domains.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/power/px30-power.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 include/dt-bindings/power/px30-power.h
> 
> diff --git a/include/dt-bindings/power/px30-power.h b/include/dt-bindings/power/px30-power.h
> new file mode 100644
> index 000000000000..4ed482e80950
> --- /dev/null
> +++ b/include/dt-bindings/power/px30-power.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Same comments here.

> + */
> +
> +#ifndef __DT_BINDINGS_POWER_PX30_POWER_H__
> +#define __DT_BINDINGS_POWER_PX30_POWER_H__
> +
> +/* VD_CORE */
> +#define PX30_PD_A35_0		0
> +#define PX30_PD_A35_1		1
> +#define PX30_PD_A35_2		2
> +#define PX30_PD_A35_3		3
> +#define PX30_PD_SCU		4
> +
> +/* VD_LOGIC */
> +#define PX30_PD_USB		5
> +#define PX30_PD_DDR		6
> +#define PX30_PD_SDCARD		7
> +#define PX30_PD_CRYPTO		8
> +#define PX30_PD_GMAC		9
> +#define PX30_PD_MMC_NAND	10
> +#define PX30_PD_VPU		11
> +#define PX30_PD_VO		12
> +#define PX30_PD_VI		13
> +#define PX30_PD_GPU		14
> +
> +/* VD_PMU */
> +#define PX30_PD_PMU		15
> +
> +#endif
> -- 
> 1.9.1
> 
> 
