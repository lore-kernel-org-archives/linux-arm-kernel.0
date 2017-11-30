From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 30 Nov 2017 10:13:53 +0100
Subject: [PATCH v4] arch: arm: mach-stm32: Fix copyright
In-Reply-To: <20171130084950.23873-1-benjamin.gaignard@st.com>
References: <20171130084950.23873-1-benjamin.gaignard@st.com>
Message-ID: <CALszF6D_jHJVyb2_s7=Dp54nF47Z0=knpE09M0u-cU2oz1--jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-30 9:49 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
> Uniformize STMicroelectronics copyrights header
> Add SPDX identifier
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  arch/arm/mach-stm32/board-dt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index e918686e4191..548a19f97129 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -1,7 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics 2017
>   * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>
>  #include <linux/kernel.h>
> --
> 2.15.0
>

Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Maxime
