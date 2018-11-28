From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 28 Nov 2018 20:29:01 +0100
Subject: [PATCH] iio: adc: Replace license text w/ SPDX identifier
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
Message-ID: <20181128192901.GG8952@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 28/11/2018 15:53:12-0200, Matheus Tavares wrote:
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index f10443f92e4c..9f9c186e2135 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  exynos_adc.c - Support for ADC in EXYNOS SoCs
>   *
> @@ -5,16 +6,6 @@
>   *
>   *  Copyright (C) 2013 Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>   *
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
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, write to the Free Software
>   *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

You forgot to remove some of the boilerplate here.

> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 36b59d8957fb..894d49843854 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * HX711: analog to digital converter for weight sensor module
>   *
>   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the

and here

> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 729becb2d3d9..f5299c9bdbde 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
>   *
>   * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * You should have received a copy of the GNU General Public License
>   * along with this program. If not, see <http://www.gnu.org/licenses/>.

and here.

>   */

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
