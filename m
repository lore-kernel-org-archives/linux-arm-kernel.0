From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Nov 2018 09:15:32 +0000
Subject: [PATCH v3 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
In-Reply-To: <20181123142411.8921-1-dev@pschenker.ch>
References: <20181123142411.8921-1-dev@pschenker.ch>
Message-ID: <20181128091532.GU4272@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Nov 2018, Philippe Schenker wrote:

> Move defines that are ADC related to the header of the overlying mfd,
> so they can be used from multiple sub-devices.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v3:
>  - None
> 
> Changes in v2:
>  - This is a new added commit. Separate commit for moving the defines out of
>    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
>  - Pre-fix defines with STMPE_
> 
>  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
>  include/linux/mfd/stmpe.h            | 11 +++++++++

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
