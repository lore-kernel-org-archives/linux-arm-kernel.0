From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 11 Dec 2017 22:45:36 +1100
Subject: [PATCH] crypto: stm32: fix module device table name
In-Reply-To: <20171130110433.15811-1-clabbe.montjoie@gmail.com>
References: <20171130110433.15811-1-clabbe.montjoie@gmail.com>
Message-ID: <20171211114536.GF12014@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 12:04:33PM +0100, Corentin Labbe wrote:
> This patch fix the following build failure:
>   CC [M]  drivers/crypto/stm32/stm32-cryp.o
> In file included from drivers/crypto/stm32/stm32-cryp.c:11:0:
> drivers/crypto/stm32/stm32-cryp.c:1049:25: error: 'sti_dt_ids' undeclared here (not in a function)
>  MODULE_DEVICE_TABLE(of, sti_dt_ids);
> 
> Let's replace sti_dt_ids with stm32_dt_ids which is just declared
> before.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
