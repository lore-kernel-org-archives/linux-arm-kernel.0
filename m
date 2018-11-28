From: vilhelm.gray@gmail.com (William Breathitt Gray)
Date: Thu, 29 Nov 2018 08:03:50 +0900
Subject: [PATCH] iio: adc: Replace license text w/ SPDX identifier
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
Message-ID: <20181128230350.GA3332@icarus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 03:53:12PM -0200, Matheus Tavares wrote:
> From: Lucas Santos <ilucas.ms@gmail.com>
> 
> This patch removes all license boilerplate texts from the .c and .h
> files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> identifiers.
> 
> Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  drivers/iio/adc/ad7266.c             |  3 +--
>  drivers/iio/adc/ad7291.c             |  3 +--
>  drivers/iio/adc/ad7298.c             |  3 +--
>  drivers/iio/adc/ad7766.c             |  3 +--
>  drivers/iio/adc/ad7791.c             |  3 +--
>  drivers/iio/adc/ad7793.c             |  3 +--
>  drivers/iio/adc/ad7887.c             |  3 +--
>  drivers/iio/adc/ad7923.c             |  3 +--
>  drivers/iio/adc/ad799x.c             |  5 +----
>  drivers/iio/adc/ad_sigma_delta.c     |  3 +--
>  drivers/iio/adc/aspeed_adc.c         |  6 +-----
>  drivers/iio/adc/at91-sama5d2_adc.c   | 10 +---------
>  drivers/iio/adc/at91_adc.c           |  3 +--
>  drivers/iio/adc/axp20x_adc.c         |  5 +----
>  drivers/iio/adc/axp288_adc.c         | 13 +------------
>  drivers/iio/adc/bcm_iproc_adc.c      | 13 +------------
>  drivers/iio/adc/berlin2-adc.c        |  5 +----
>  drivers/iio/adc/cc10001_adc.c        |  6 +-----
>  drivers/iio/adc/cpcap-adc.c          | 10 +---------
>  drivers/iio/adc/da9150-gpadc.c       |  6 +-----
>  drivers/iio/adc/dln2-adc.c           |  5 +----
>  drivers/iio/adc/ep93xx_adc.c         |  5 +----
>  drivers/iio/adc/exynos_adc.c         | 11 +----------
>  drivers/iio/adc/fsl-imx25-gcq.c      |  5 +----
>  drivers/iio/adc/hi8435.c             |  6 +-----
>  drivers/iio/adc/hx711.c              |  6 +-----
>  drivers/iio/adc/imx7d_adc.c          |  6 +-----
>  drivers/iio/adc/ina2xx-adc.c         |  7 +------
>  drivers/iio/adc/lp8788_adc.c         |  5 +----
>  drivers/iio/adc/lpc18xx_adc.c        |  5 +----
>  drivers/iio/adc/lpc32xx_adc.c        | 15 +--------------
>  drivers/iio/adc/ltc2471.c            |  3 +--
>  drivers/iio/adc/ltc2485.c            |  5 +----
>  drivers/iio/adc/ltc2497.c            |  3 +--
>  drivers/iio/adc/max1027.c            |  5 +----
>  drivers/iio/adc/max1118.c            |  5 +----
>  drivers/iio/adc/max1363.c            |  5 +----
>  drivers/iio/adc/mcp320x.c            |  5 +----
>  drivers/iio/adc/mcp3422.c            |  6 +-----
>  drivers/iio/adc/men_z188_adc.c       |  5 +----
>  drivers/iio/adc/meson_saradc.c       |  5 +----
>  drivers/iio/adc/mt6577_auxadc.c      | 10 +---------
>  drivers/iio/adc/mxs-lradc-adc.c      | 11 +----------
>  drivers/iio/adc/nau7802.c            |  3 +--
>  drivers/iio/adc/palmas_gpadc.c       |  5 +----
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
>  drivers/iio/adc/qcom-spmi-iadc.c     | 10 +---------
>  drivers/iio/adc/qcom-spmi-vadc.c     | 10 +---------
>  drivers/iio/adc/rockchip_saradc.c    | 11 +----------
>  drivers/iio/adc/spear_adc.c          |  3 +--
>  drivers/iio/adc/stx104.c             | 10 +---------
>  drivers/iio/adc/sun4i-gpadc-iio.c    |  5 +----
>  drivers/iio/adc/ti-adc081c.c         |  5 +----
>  drivers/iio/adc/ti-adc0832.c         |  5 +----
>  drivers/iio/adc/ti-adc084s021.c      |  5 +----
>  drivers/iio/adc/ti-adc108s102.c      | 10 +---------
>  drivers/iio/adc/ti-adc12138.c        |  5 +----
>  drivers/iio/adc/ti-ads1015.c         |  5 +----
>  drivers/iio/adc/ti-ads8688.c         |  5 +----
>  drivers/iio/adc/ti-tlc4541.c         |  5 +----
>  drivers/iio/adc/ti_am335x_adc.c      | 10 +---------
>  drivers/iio/adc/twl4030-madc.c       | 16 +---------------
>  drivers/iio/adc/twl6030-gpadc.c      | 16 +---------------
>  drivers/iio/adc/vf610_adc.c          | 15 +--------------
>  drivers/iio/adc/viperboard_adc.c     |  7 +------
>  drivers/iio/adc/xilinx-xadc-core.c   |  3 +--
>  drivers/iio/adc/xilinx-xadc-events.c |  3 +--
>  drivers/iio/adc/xilinx-xadc.h        |  3 +--
>  68 files changed, 68 insertions(+), 361 deletions(-)
> 
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> index 0662ca199eb0..f9d0aaae836f 100644
> --- a/drivers/iio/adc/stx104.c
> +++ b/drivers/iio/adc/stx104.c
> @@ -1,15 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * IIO driver for the Apex Embedded Systems STX104
>   * Copyright (C) 2016 William Breathitt Gray
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, version 2, as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
>   */
>  #include <linux/bitops.h>
>  #include <linux/device.h>

For stx104.c:

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
