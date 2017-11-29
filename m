From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Wed, 29 Nov 2017 16:16:11 +0100
Subject: [PATCH v2] arch: arm: mach-stm32: Fix copyright
In-Reply-To: <20171129145502.30793-1-benjamin.gaignard@st.com>
References: <20171129145502.30793-1-benjamin.gaignard@st.com>
Message-ID: <CAOFm3uHk3+WniPNTH82Lc8O+J3ywEYF1fy4raREFkY0p4Mvqcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 3:55 PM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Uniformize STMicroelectronics copyrights header
> Add SPDX identifier
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/mach-stm32/board-dt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index e918686e4191..b01f40543e6e 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -1,5 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>   * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>   * License terms:  GNU General Public License (GPL), version 2
>   */

My 2 cents:
Linus commented on the comment style and unless the code demands /**/
comments as in a few .h also used in assembly, the style to use should
be a top level line this way:

> +// SPDX-License-Identifier: GPL-2.0

You can check the rationale in recent threads on this very topic.
Thomas (tglx) also wrote the doc on this.

-- 
Cordially
Philippe Ombredanne
