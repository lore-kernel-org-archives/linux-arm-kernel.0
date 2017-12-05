From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 5 Dec 2017 09:23:37 -0800
Subject: [v2] mfd: stm32: Adopt SPDX identifier
In-Reply-To: <20171205152418.28104-1-benjamin.gaignard@st.com>
References: <20171205152418.28104-1-benjamin.gaignard@st.com>
Message-ID: <20171205172337.GA24480@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 04:24:18PM +0100, benjamin.gaignard at linaro.org wrote:
> Add SPDX identifier
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/mfd/stm32-lptimer.c       | 6 +-----
>  drivers/mfd/stm32-timers.c        | 4 +---
>  include/linux/mfd/stm32-lptimer.h | 6 +-----
>  include/linux/mfd/stm32-timers.h  | 4 +---
>  4 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
> index 075330a25f61..a00f99f36559 100644
> --- a/drivers/mfd/stm32-lptimer.c
> +++ b/drivers/mfd/stm32-lptimer.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*

I have been wondering - why is the SPDX identifier for the most part added
as separate C++ comment at the beginning of the file, and not inline with
the rest of the top comments ?  SPDX doesn't mandate this - the examples
I can find on the SPDX web site all show it inline. Is there a special
Linux kernel convention ?

Thanks,
Guenter

>   * STM32 Low-Power Timer parent driver.
> - *
>   * Copyright (C) STMicroelectronics 2017
> - *
>   * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
> - *
>   * Inspired by Benjamin Gaignard's stm32-timers driver
> - *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>  
>  #include <linux/mfd/stm32-lptimer.h>
> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index a6675a449409..1d347e5dfa79 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -1,9 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) STMicroelectronics 2016
> - *
>   * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
> - *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>  
>  #include <linux/mfd/stm32-timers.h>
> diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
> index 77c7cf40d9b4..605f62264825 100644
> --- a/include/linux/mfd/stm32-lptimer.h
> +++ b/include/linux/mfd/stm32-lptimer.h
> @@ -1,13 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * STM32 Low-Power Timer parent driver.
> - *
>   * Copyright (C) STMicroelectronics 2017
> - *
>   * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
> - *
>   * Inspired by Benjamin Gaignard's stm32-timers driver
> - *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>  
>  #ifndef _LINUX_STM32_LPTIMER_H_
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index ce7346e7f77a..2aadab6f34a1 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -1,9 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) STMicroelectronics 2016
> - *
>   * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
> - *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>  
>  #ifndef _LINUX_STM32_GPTIMER_H_
