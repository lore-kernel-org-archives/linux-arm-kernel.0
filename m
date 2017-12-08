From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 8 Dec 2017 14:46:25 +0100
Subject: [PATCH v9 5/6] clocksource: stm32: Update license and copyright
In-Reply-To: <20171208113250.359-6-benjamin.gaignard@st.com>
References: <20171208113250.359-1-benjamin.gaignard@st.com>
 <20171208113250.359-6-benjamin.gaignard@st.com>
Message-ID: <CAOFm3uEGweexMydumojVKBuJ6QskBV+zWXUQBCx67dZvhiXrxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 8, 2017 at 12:32 PM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Adopt SPDX License Identifier and add STMicroelectronics
> copyright
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/clocksource/timer-stm32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
> index c9aed2314194..21479c3cfcb9 100644
> --- a/drivers/clocksource/timer-stm32.c
> +++ b/drivers/clocksource/timer-stm32.c
> @@ -1,7 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
>   * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
> - * License terms:  GNU General Public License (GPL), version 2
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
>   *
>   * Inspired by time-efm32.c from Uwe Kleine-Koenig
>   */
> --
> 2.15.0
>

Benjamin,

Thank you for this: every little bit of help counts towards making the
whole kernel licensing easily greppable!

FWIW:

Reviewed-by: Philippe Ombredanne <pombredanne@nexB.com>

--
Philippe
