From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 7 Dec 2017 11:11:31 +0100
Subject: [PATCH] mfd: stm32: Adopt SPDX identifier
In-Reply-To: <20171205145809.20514-1-benjamin.gaignard@st.com>
References: <20171205145809.20514-1-benjamin.gaignard@st.com>
Message-ID: <CAOFm3uHNpE0TMhjdm5gLjOUOc7zivx1Swzg=CniXG5GKmQuCjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 3:58 PM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Add SPDX identifier
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/mfd/stm32-lptimer.c       | 2 +-
>  drivers/mfd/stm32-timers.c        | 2 +-
>  include/linux/mfd/stm32-lptimer.h | 2 +-
>  include/linux/mfd/stm32-timers.h  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
> index 075330a25f61..2606e340c9f7 100644
> --- a/drivers/mfd/stm32-lptimer.c
> +++ b/drivers/mfd/stm32-lptimer.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * STM32 Low-Power Timer parent driver.
>   *
> @@ -7,7 +8,6 @@
>   *
>   * Inspired by Benjamin Gaignard's stm32-timers driver
>   *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>
>  #include <linux/mfd/stm32-lptimer.h>
> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index a6675a449409..250c4c4411cd 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -1,9 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) STMicroelectronics 2016
>   *
>   * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
>   *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>
>  #include <linux/mfd/stm32-timers.h>
> diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
> index 77c7cf40d9b4..e5a2cc8aea56 100644
> --- a/include/linux/mfd/stm32-lptimer.h
> +++ b/include/linux/mfd/stm32-lptimer.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * STM32 Low-Power Timer parent driver.
>   *
> @@ -7,7 +8,6 @@
>   *
>   * Inspired by Benjamin Gaignard's stm32-timers driver
>   *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>
>  #ifndef _LINUX_STM32_LPTIMER_H_
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index ce7346e7f77a..13ffe2696e4b 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -1,9 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) STMicroelectronics 2016
>   *
>   * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
>   *
> - * License terms:  GNU General Public License (GPL), version 2
>   */
>
>  #ifndef _LINUX_STM32_GPTIMER_H_
> --
> 2.15.0
>

Thank you for using the simpler SPDX license ids!

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
