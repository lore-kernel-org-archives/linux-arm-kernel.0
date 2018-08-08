From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 8 Aug 2018 20:43:54 +0300
Subject: [PATCH 07/28] ARM: davinci: dm365-evm: use nvmem lookup for mac
 address
In-Reply-To: <20180808153150.23444-8-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808153150.23444-8-brgl@bgdev.pl>
Message-ID: <CAHp75VdXTS9kg5PF-YrTbi8f1U9qSKU+1D43-p0PgphKeJdVNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We now support nvmem lookups for machine code. Add a lookup for
> mac-address.

>  #include <linux/spi/spi.h>
>  #include <linux/spi/eeprom.h>
>  #include <linux/v4l2-dv-timings.h>
> +#include <linux/nvmem-provider.h>

It looks from this context that your patch broke the order.

P.S. Can you verify all in the series for this?

-- 
With Best Regards,
Andy Shevchenko
