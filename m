From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Sun, 29 Oct 2017 18:51:25 +0100
Subject: [PATCH v2 3/3] mtd: spi-nor: stm32-quadspi: change license text
In-Reply-To: <1509030755-19044-4-git-send-email-ludovic.Barre@st.com>
References: <1509030755-19044-1-git-send-email-ludovic.Barre@st.com>
 <1509030755-19044-4-git-send-email-ludovic.Barre@st.com>
Message-ID: <6d132904-bea7-2ecc-f9d9-73c7cc5f0c3d@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/10/2017 ? 17:12, Ludovic Barre a ?crit?:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> -Change the license text with long template.
> -Change Copyright to STMicroelectronics.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied to the spi-nor/next branch of l2-mtd

Thanks!
> ---
>  drivers/mtd/spi-nor/stm32-quadspi.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
> index 70710be..b3c7f6a 100644
> --- a/drivers/mtd/spi-nor/stm32-quadspi.c
> +++ b/drivers/mtd/spi-nor/stm32-quadspi.c
> @@ -1,9 +1,22 @@
>  /*
> - * stm32_quadspi.c
> + * Driver for stm32 quadspi controller
>   *
> - * Copyright (C) 2017, Ludovic Barre
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Ludovic Barre author <ludovic.barre@st.com>.
>   *
> - * License terms: GNU General Public License (GPL), version 2
> + * License terms: GPL V2.0.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * This program. If not, see <http://www.gnu.org/licenses/>.
>   */
>  #include <linux/clk.h>
>  #include <linux/errno.h>
> 
