From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 29 Nov 2017 16:07:25 +0100
Subject: [PATCH v2] arch: arm: mach-stm32: Fix copyright
In-Reply-To: <20171129145502.30793-1-benjamin.gaignard@st.com>
References: <20171129145502.30793-1-benjamin.gaignard@st.com>
Message-ID: <ea89d917-c7b4-da09-825e-88f566f42905@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/29/2017 03:55 PM, Benjamin Gaignard wrote:
> Uniformize STMicroelectronics copyrights header
> Add SPDX identifier
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/mach-stm32/board-dt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index e918686e4191..b01f40543e6e 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -1,5 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>    * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>    * License terms:  GNU General Public License (GPL), version 2
>    */
> 
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
