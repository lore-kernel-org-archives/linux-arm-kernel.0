From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 31 May 2016 18:18:00 +0800
Subject: [PATCH] hwrng: stm32: fix maybe uninitialized variable warning
In-Reply-To: <1464255297-21090-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1464255297-21090-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <20160531101800.GI15376@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 11:34:57AM +0200, Maxime Coquelin wrote:
> This patch fixes the following warning:
> drivers/char/hw_random/stm32-rng.c: In function 'stm32_rng_read':
> drivers/char/hw_random/stm32-rng.c:82:19: warning: 'sr' may be used
>                                         uninitialized in this function
> 
> Reported-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
