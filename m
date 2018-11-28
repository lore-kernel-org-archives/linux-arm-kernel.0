From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 29 Nov 2018 00:20:02 +0200
Subject: [PATCH] iio: adc: Replace license text w/ SPDX identifier
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
Message-ID: <ac2e8875-f4c8-70be-6ff6-9a7cbd3f3e46@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2018 07:53 PM, Matheus Tavares wrote:
> From: Lucas Santos <ilucas.ms@gmail.com>
> 
> This patch removes all license boilerplate texts from the .c and .h
> files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> identifiers.
> 
> Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

[snip]

> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> index 041dc4a3f66c..00d39234143d 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * IIO ADC driver for NXP LPC18xx ADC
>   *
>   * Copyright (C) 2016 Joachim Eastwood <manabian@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * UNSUPPORTED hardware features:
>   *  - Hardware triggers
>   *  - Burst mode
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 20b36690fa4f..e361c1532a75 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -1,23 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  lpc32xx_adc.c - Support for ADC in LPC32XX
>   *
>   *  3-channel, 10-bit ADC
>   *
>   *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
>  #include <linux/module.h>

For lpc18xx/lpc32xx:

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
