From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Sep 2014 17:30:19 +0200
Subject: [PATCH v2] spi: pl022: Add support for chip select extension
In-Reply-To: <1410936418-26443-1-git-send-email-anders.berg@avagotech.com>
References: <20140916183431.GX7960@sirena.org.uk>
 <1410936418-26443-1-git-send-email-anders.berg@avagotech.com>
Message-ID: <CACRpkdZhhfLM027THE6Gb_QGf4+eswybH3kEun18XCznJcLH8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 8:46 AM, Anders Berg <anders.berg@avagotech.com> wrote:

> Add support for a extended PL022 which has an extra register for controlling up
> to five chip select signals. This controller is found on the AXM5516 SoC.
> Unfortunately the PrimeCell identification registers are identical to a
> standard ARM PL022. To work around this, the peripheral ID must be overridden
> in the device tree using the "arm,primecell-periphid" property with the value
> 0x000b6022.
>
> Signed-off-by: Anders Berg <anders.berg@avagotech.com>
> ---
>
> Adding Russell to Cc.
>
> Changelog:
>
> v2:
>     - added constant to <linux/amba/bus.h>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
