From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Wed, 29 Nov 2017 15:40:50 +0100
Subject: [PATCH] arch: arm: mach-stm32: Fix copyright
In-Reply-To: <20171129141331.21558-1-benjamin.gaignard@st.com>
References: <20171129141331.21558-1-benjamin.gaignard@st.com>
Message-ID: <CAOFm3uFE2j5H4hJThEPCngud=6JsnWsNM7MR5Yp13dVGGgpXmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benjamin:

On Wed, Nov 29, 2017 at 3:13 PM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Uniformize STMicroelectronics copyrights header
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/mach-stm32/board-dt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index e918686e4191..df432bb53d03 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>   * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>   * License terms:  GNU General Public License (GPL), version 2
>   */

While you are this here and elsewhere, why not adopt the new SPDX id
convention at the same time?

eg:
>  + // SPDX-License-Identifier:  GPL-2.0
>  /*
>   * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>   * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>  - * License terms:  GNU General Public License (GPL), version 2

-- 
Cordially
Philippe Ombredanne
