From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 7 Dec 2017 11:11:13 +0100
Subject: [PATCH] pwn: stm32: Adopt SPDX identifier
In-Reply-To: <20171205145721.20403-1-benjamin.gaignard@st.com>
References: <20171205145721.20403-1-benjamin.gaignard@st.com>
Message-ID: <CAOFm3uFYjUvnwb2zqdJEuHp4WEnfmxrcZxRta2Cnfz3Q1=55rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 3:57 PM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Add SPDX identifer
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 3 +--
>  drivers/pwm/pwm-stm32.c    | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 1ac9e4384142..cbd271e80c3c 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * STM32 Low-Power Timer PWM driver
>   *
> @@ -5,8 +6,6 @@
>   *
>   * Author: Gerald Baeza <gerald.baeza@st.com>
>   *
> - * License terms: GNU General Public License (GPL), version 2
> - *
>   * Inspired by Gerald Baeza's pwm-stm32 driver
>   */
>
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 6139512aab7b..be56d7af89c9 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) STMicroelectronics 2016
>   *
>   * Author: Gerald Baeza <gerald.baeza@st.com>
>   *
> - * License terms: GNU General Public License (GPL), version 2
> - *
>   * Inspired by timer-stm32.c from Maxime Coquelin
>   *             pwm-atmel.c from Bo Shen
>   */
> --
> 2.15.0
>


Thank you for using the simpler SPDX license ids!

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
