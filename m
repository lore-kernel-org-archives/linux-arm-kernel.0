From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 12 Mar 2014 20:11:01 +0800
Subject: [PATCH 3/3 V2] crypto: Simplify the ahash_finup implementation
In-Reply-To: <1393806108-6374-3-git-send-email-marex@denx.de>
References: <1389720829-5963-1-git-send-email-marex@denx.de>
 <1393806108-6374-1-git-send-email-marex@denx.de>
 <1393806108-6374-3-git-send-email-marex@denx.de>
Message-ID: <20140312121101.GB25881@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 01:21:48AM +0100, Marek Vasut wrote:
>
> -static void ahash_def_finup_done2(struct crypto_async_request *req, int err)
> +static void ahash_def_finup_done2(struct crypto_async_request *areq, int err)

Please keep the existing name to be consistent with the rest
of the crypto API code.  You should also use the same name in
your second patch for consistency.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
