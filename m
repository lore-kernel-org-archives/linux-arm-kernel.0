From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 15 Oct 2015 10:00:37 +0800
Subject: [PATCH] hwrng: stm32 - Fix build with CONFIG_PM
In-Reply-To: <1444838695-7182-1-git-send-email-daniel.thompson@linaro.org>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
 <1444838695-7182-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20151015020037.GA22342@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 05:04:55PM +0100, Daniel Thompson wrote:
> Commit c6a97c42e399 ("hwrng: stm32 - add support for STM32 HW RNG")
> was inadequately tested (actually it was tested quite hard so
> incompetent would be a better description that inadequate) and does
> not compile on platforms with CONFIG_PM set.
> 
> Fix this.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
