From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2012 23:22:28 +0200
Subject: [PATCH v2] spi/pl022: Devicetree support w/o platform data
In-Reply-To: <1347976433-1176-1-git-send-email-stigge@antcom.de>
References: <1347976433-1176-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdacODp0QTiZyBX46Bm61_98QN=X+GJJ7G44AXx9Eq2BHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 3:53 PM, Roland Stigge <stigge@antcom.de> wrote:

> Even with devicetree support, we needed platform data to provide some data,
> leading to mixed device tree and platform data. This patch makes it possible to
> provide all that information via device tree. Now, the data must be provided
> via platform data _or_ device tree completely.
>
> Only in case of DMA where a callback specification is necessary (dma_filter()),
> platform data is the only option.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
