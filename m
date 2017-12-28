From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 28 Dec 2017 18:08:17 +1100
Subject: [PATCH] crypto: stm32 - Use standard CONFIG name
In-Reply-To: <1513793972-11173-1-git-send-email-clabbe@baylibre.com>
References: <1513793972-11173-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20171228070817.GE9639@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 06:19:32PM +0000, Corentin Labbe wrote:
> All hardware crypto devices have their CONFIG names using the following
> convention:
> CRYPTO_DEV_name_algo
> 
> This patch apply this conventions on STM32 CONFIG names.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
