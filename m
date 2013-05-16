From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 16 May 2013 15:01:33 +0800
Subject: [PATCH 13/39] crypto: ux500/hash - Set DMA configuration
 though dma_slave_config()
In-Reply-To: <1368611522-9984-14-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-14-git-send-email-lee.jones@linaro.org>
Message-ID: <20130516070132.GA6721@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 10:51:36AM +0100, Lee Jones wrote:
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
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
