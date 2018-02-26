From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 26 Feb 2018 18:01:37 +0100
Subject: [PATCH v4] arch: arm: mach-stm32: Fix copyright
In-Reply-To: <20171130084950.23873-1-benjamin.gaignard@st.com>
References: <20171130084950.23873-1-benjamin.gaignard@st.com>
Message-ID: <29bf34f5-9b63-9184-b219-879155f7f78f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 11/30/2017 09:49 AM, Benjamin Gaignard wrote:
> Uniformize STMicroelectronics copyrights header
> Add SPDX identifier
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>   arch/arm/mach-stm32/board-dt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index e918686e4191..548a19f97129 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -1,7 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics 2017
>    * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
> - * License terms:  GNU General Public License (GPL), version 2
>    */
>   
>   #include <linux/kernel.h>
> 

Applied on stm32-next.

Regards
Alex
