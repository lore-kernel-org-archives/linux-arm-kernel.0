From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 28 Jun 2016 10:32:26 +0200
Subject: [PATCH 2/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <1467101897-15946-3-git-send-email-quentin.schulz@free-electrons.com>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-3-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <20160628083226.GD4472@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Quentin!

On Tue, Jun 28, 2016 at 10:18:16AM +0200, Quentin Schulz wrote:
>
> diff --git a/drivers/iio/adc/sunxi-gpadc-iio.c b/drivers/iio/adc/sunxi-gpadc-iio.c
> new file mode 100644
> index 0000000..5840f43
> --- /dev/null
> +++ b/drivers/iio/adc/sunxi-gpadc-iio.c
> @@ -0,0 +1,371 @@

Same here, you can add a license statement :-)

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +#include <linux/regmap.h>

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/ae363f57/attachment.sig>
