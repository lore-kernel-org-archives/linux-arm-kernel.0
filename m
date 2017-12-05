From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 5 Dec 2017 15:15:57 +0000
Subject: [PATCH] mfd: stm32: Adopt SPDX identifier
In-Reply-To: <20171205145809.20514-1-benjamin.gaignard@st.com>
References: <20171205145809.20514-1-benjamin.gaignard@st.com>
Message-ID: <20171205151557.patcdcaghl3dwfgl@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Dec 2017, Benjamin Gaignard wrote:

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

Nit, can you also remove the blank line above please?

Same will all of the below.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
