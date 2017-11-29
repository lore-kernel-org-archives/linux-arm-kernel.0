From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 29 Nov 2017 16:07:16 +0100
Subject: [PATCH] watchdog: stm32: Fix copyright
In-Reply-To: <20171129142753.23681-1-benjamin.gaignard@st.com>
References: <20171129142753.23681-1-benjamin.gaignard@st.com>
Message-ID: <36092e5c-c314-8e21-b7b3-ac25c5e427bb@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/29/2017 03:27 PM, Benjamin Gaignard wrote:
> Uniformize STMicroelectronics copyrights header
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Yannick Fertre <yannick.fertre@st.com>
> ---
>   drivers/watchdog/stm32_iwdg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index be64a8699de3..c6c8351f1598 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -1,8 +1,8 @@
>   /*
>    * Driver for STM32 Independent Watchdog
>    *
> - * Copyright (C) Yannick Fertre 2017
> - * Author: Yannick Fertre <yannick.fertre@st.com>
> + * Copyright (C) STMicroelectronics SA 2017
> + * Author: Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
>    *
>    * This driver is based on tegra_wdt.c
>    *
> 
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
