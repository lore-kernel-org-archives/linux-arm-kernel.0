From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 29 Nov 2017 16:06:46 +0100
Subject: [PATCH] pinctrl: stm32: Fix copyright
In-Reply-To: <20171129142532.23468-1-benjamin.gaignard@st.com>
References: <20171129142532.23468-1-benjamin.gaignard@st.com>
Message-ID: <cba426d9-daa6-b9be-22bc-2bcc72978f25@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/29/2017 03:25 PM, Benjamin Gaignard wrote:
> Uniformize STMicroelectronics copyrights header
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c     | 1 +
>   drivers/pinctrl/stm32/pinctrl-stm32.h     | 1 +
>   drivers/pinctrl/stm32/pinctrl-stm32f429.c | 1 +
>   drivers/pinctrl/stm32/pinctrl-stm32f469.c | 4 ++--
>   drivers/pinctrl/stm32/pinctrl-stm32f746.c | 1 +
>   drivers/pinctrl/stm32/pinctrl-stm32h743.c | 4 ++--
>   6 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index a276c61be217..0676a254caeb 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>    * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>    * License terms:  GNU General Public License (GPL), version 2
>    *
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
> index 8702a9992ce5..76027765144b 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.h
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>    * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>    * License terms:  GNU General Public License (GPL), version 2
>    */
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f429.c b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
> index 4bbade25acc6..4987fe553a1a 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32f429.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>    * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>    * License terms:  GNU General Public License (GPL), version 2
>    */
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f469.c b/drivers/pinctrl/stm32/pinctrl-stm32f469.c
> index 86c8cebfa9b9..292ec13d7364 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32f469.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32f469.c
> @@ -1,6 +1,6 @@
>   /*
> - * Copyright (C) Alexandre Torgue 2016
> - * Author:  Alexandre Torgue <alexandre.torgue@st.com>
> + * Copyright (C) STMicroelectronics SA 2017
> + * Author:  Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
>    * License terms:  GNU General Public License (GPL), version 2
>    */
>   #include <linux/init.h>
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f746.c b/drivers/pinctrl/stm32/pinctrl-stm32f746.c
> index a2fae7357c36..c22972e4b96c 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32f746.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32f746.c
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics SA 2017
>    * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>    * License terms:  GNU General Public License (GPL), version 2
>    */
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32h743.c b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> index e34b2b9217ce..34ed8220ffdf 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> @@ -1,6 +1,6 @@
>   /*
> - * Copyright (C) Alexandre Torgue 2017
> - * Author:  Alexandre Torgue <alexandre.torgue@st.com>
> + * Copyright (C) STMicroelectronics SA 2017
> + * Author:  Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
>    * License terms:  GNU General Public License (GPL), version 2
>    */
>   #include <linux/init.h>
> 
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
