From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Sep 2017 09:29:48 +0100
Subject: [PATCH v4 2/6] iio: adc: sun4i-gpadc-iio: rename A33-specified
 registers to contain A33
In-Reply-To: <20170914145251.21784-3-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-3-icenowy@aosc.io>
Message-ID: <20170918082948.2bl5e44tzsufdj7n@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Sep 2017, Icenowy Zheng wrote:

> As the H3 SoC, which is also in sun8i line, has totally different
> register map for the thermal sensor (a cut down version of GPADC), we
> should rename A23/A33-specified registers to contain A33, in order to
> prevent obfuscation with H3 registers. Currently these registers are
> only prefixed "SUN8I", not "SUN8I_A33".
> 
> Add "_A33" after "SUN8I" on the register names.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v4:
> - Change A23 to A33, as the driver never supports A23.
> 
>  drivers/iio/adc/sun4i-gpadc-iio.c | 2 +-

>  include/linux/mfd/sun4i-gpadc.h   | 6 +++---

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
