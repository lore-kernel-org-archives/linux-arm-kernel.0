From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:58:01 -0700
Subject: [PATCH 1/6] ARM/dma: pl08x: pass reasonable memcpy settings
In-Reply-To: <20170408120457.22750-1-linus.walleij@linaro.org>
References: <20170408120457.22750-1-linus.walleij@linaro.org>
Message-ID: <20170419135801.GH29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 02:04:52PM +0200, Linus Walleij wrote:
> We cannot use bits from configuration registers as API between
> platforms and driver like this, abstract it out to two enums
> and mimic the stuff passed as device tree data.
> 
> This is done to make it possible for the driver to generate the
> ccfg word on-the-fly so we can support more PL08x derivatives.
> 
> Cc: arm at kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: I'd like your ACK on this eventually, it needs to
> go through the DMA engine tree with the patches following this one.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
