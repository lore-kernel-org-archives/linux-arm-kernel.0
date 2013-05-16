From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 16 May 2013 15:02:17 +0800
Subject: [PATCH 18/39] crypto: ux500/[cryp|hash] - Show successful
 start-up in the bootlog
In-Reply-To: <1368611522-9984-19-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-19-git-send-email-lee.jones@linaro.org>
Message-ID: <20130516070217.GD6721@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 10:51:41AM +0100, Lee Jones wrote:
> The Cryp driver is currently silent and the Hash driver prints the
> name of its probe function unnecessarily. Let's just put a nice
> descriptive one-liner there instead.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
