From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 14:12:17 +0200
Subject: [PATCH 16/39] crypto: ux500/cryp - Set DMA configuration though
 dma_slave_config()
In-Reply-To: <1368611522-9984-17-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-17-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaROt9-L-VY8bh7Xj7W+4-VgVVOxedbt_JeGRyRi3aLEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The DMA controller currently takes configuration information from
> information passed though dma_channel_request(), but it shouldn't.
> Using the API, the DMA channel should only be configured during
> a dma_slave_config() call.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied with Herbert's ACK.

Thanks,
Linus Walleij
