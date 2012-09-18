From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2012 14:03:28 +0200
Subject: [PATCH] spi/pl022: Devicetree support w/o platform data
In-Reply-To: <1347901159-3665-1-git-send-email-stigge@antcom.de>
References: <1347901159-3665-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdbRQsLWT=xocPTQnLVU34MGSX6XgZ+-f3w-hOetzwnbuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 6:59 PM, Roland Stigge <stigge@antcom.de> wrote:

> Even with devicetree support, we needed platform data to provide some data like
> bus_id and enable_dma, leading to mixed device tree and platform data. This
> patch makes it possible to provide all that information via device tree. Now,
> the data must be provided via platform data _or_ device tree completely.
>
> Only in case of callback specification (dma_filter()), platform data is
> necessary.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

This looks good so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But I think you need to page Mark Brown so it
gets picked to the stuff queued for the next merge window.
I think the dependent patch is in his SPI tree.

So I'd resend it to mark+grant with my ACK.

Yours,
Linus Walleij
