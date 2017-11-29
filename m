From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 29 Nov 2017 07:54:45 -0800
Subject: [PATCH] watchdog: stm32: Fix copyright
In-Reply-To: <20171129142753.23681-1-benjamin.gaignard@st.com>
References: <20171129142753.23681-1-benjamin.gaignard@st.com>
Message-ID: <20171129155445.GB17729@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 03:27:53PM +0100, Benjamin Gaignard wrote:
> Uniformize STMicroelectronics copyrights header
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Yannick Fertre <yannick.fertre@st.com>
> ---
>  drivers/watchdog/stm32_iwdg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index be64a8699de3..c6c8351f1598 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -1,8 +1,8 @@
>  /*
>   * Driver for STM32 Independent Watchdog
>   *
> - * Copyright (C) Yannick Fertre 2017
> - * Author: Yannick Fertre <yannick.fertre@st.com>
> + * Copyright (C) STMicroelectronics SA 2017
> + * Author: Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.

This will require an Ack from Yannick.

Guenter
