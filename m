From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 9 Feb 2018 23:51:32 +0800
Subject: [PATCH 0/2] sun4i_ss_prng fixes
In-Reply-To: <20180206212022.1309-1-artem.savkov@gmail.com>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
Message-ID: <20180209155132.GD22273@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 06, 2018 at 10:20:20PM +0100, Artem Savkov wrote:
> IPSec hasn't been working on my a10 board since 4.14 and it turned out to be
> caused by sun4i_ss_rng driver.
> 
> Artem Savkov (2):
>   sun4i_ss_prng: fix return value of sun4i_ss_prng_generate
>   sun4i_ss_prng: convert lock to _bh in sun4i_ss_prng_generate
> 
>  drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
