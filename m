From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 Nov 2018 12:14:30 +0000
Subject: [PATCH v2 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
In-Reply-To: <20181119102528.2830-1-dev@pschenker.ch>
References: <20181119102528.2830-1-dev@pschenker.ch>
Message-ID: <20181127121430.GJ4272@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2018, Philippe Schenker wrote:

> Move defines that are ADC related to the header of the overlying mfd,
> so they can be used from multiple sub-devices.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v2:
>  - This is a new added commit. Separate commit for moving the defines out of
>    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
>  - Pre-fix defines with STMPE_
> 
>  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
>  include/linux/mfd/stmpe.h            | 11 +++++++++
>  2 files changed, 24 insertions(+), 21 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
