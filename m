From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Wed, 29 Nov 2017 18:02:56 +0100
Subject: [PATCH v3] arch: arm: mach-stm32: Fix copyright
In-Reply-To: <20171129152523.5262-1-benjamin.gaignard@st.com>
References: <20171129152523.5262-1-benjamin.gaignard@st.com>
Message-ID: <CAOFm3uFAnS9x248di7S_re7P90+oPvyyiBGbmtqV26NEoOv7GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 4:25 PM, Benjamin Gaignard
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
> index e918686e4191..77899ae4b8ed 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -1,5 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>   * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>   * License terms:  GNU General Public License (GPL), version 2
>   */

Sorry to be picky there, but you can now rightfully remove this line
IMHO as the "SPDX-License-Identifier: GPL-2.0" already covers it now
e.g:

> - * License terms:  GNU General Public License (GPL), version 2

-- 
Cordially
Philippe Ombredanne
