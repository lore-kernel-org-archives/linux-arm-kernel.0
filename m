From: jic23@kernel.org (Jonathan Cameron)
Date: Fri, 29 Mar 2013 09:28:31 +0000
Subject: [PATCH 02/13] iio: mxs-lradc: remove unneeded mach header
 inclusion
In-Reply-To: <1364547350-30498-3-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
 <1364547350-30498-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <51555EBF.70308@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 08:55 AM, Shawn Guo wrote:
> Headers <mach/mxs.h> and <mach/common.h> are not used in the driver
> at all.  Removed the inclusions.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio at vger.kernel.org
Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 55a459b..0eb5b4d 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -36,9 +36,6 @@
>  #include <linux/delay.h>
>  #include <linux/input.h>
>  
> -#include <mach/mxs.h>
> -#include <mach/common.h>
> -
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
> 
