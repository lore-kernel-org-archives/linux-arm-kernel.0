From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 12:29:31 +0200
Subject: [PATCH v7 2/3] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <1396519224-18712-3-git-send-email-rahul.sharma@samsung.com>
References: <1396519224-18712-1-git-send-email-rahul.sharma@samsung.com>
 <1396519224-18712-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <5345210B.5070807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 03.04.2014 12:00, Rahul Sharma wrote:
> The patch adds the dts files for exynos5260.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5260-pinctrl.dtsi |  574 +++++++++++++++++++++++++++++
>   arch/arm/boot/dts/exynos5260.dtsi         |  304 +++++++++++++++
>   2 files changed, 878 insertions(+)
>   create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/exynos5260.dtsi

[snip]

> diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
> new file mode 100644
> index 0000000..188a2ac
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5260.dtsi
> @@ -0,0 +1,304 @@
> +/*
> + * SAMSUNG EXYNOS5260 SoC device tree source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include "skeleton.dtsi"
> +
> +#include <dt-bindings/clock/exynos5260-clk.h>
> +
> +/ {
> +	compatible = "samsung,exynos5260";

Since Sachin's patches, "samsung,exynos5" compatible should be also 
added, before the more specific ones.

Best regards,
Tomasz
