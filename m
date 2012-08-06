From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 10:37:45 +0800
Subject: [PATCH 2/3 V2] IIO: Add basic MXS LRADC driver
In-Reply-To: <1344007721-11595-3-git-send-email-marex@denx.de>
References: <1344007721-11595-1-git-send-email-marex@denx.de>
 <1344007721-11595-3-git-send-email-marex@denx.de>
Message-ID: <20120806023743.GC18471@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 05:28:40PM +0200, Marek Vasut wrote:
> --- /dev/null
> +++ b/drivers/staging/iio/adc/mxs-lradc.c

<snip>

> +#include <mach/mxs.h>
> +#include <mach/common.h>
> +
Why do you need these two mach headers?

-- 
Regards,
Shawn
