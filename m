From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 24 Aug 2016 21:14:19 +0800
Subject: [PATCH -next v2] crypto: sun4i-ss - fix missing unlock on error
 in sun4i_hash()
In-Reply-To: <1471690133-24396-1-git-send-email-weiyj.lk@gmail.com>
References: <1471560130-5265-1-git-send-email-weiyj.lk@gmail.com>
 <1471690133-24396-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160824131419.GD3850@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2016 at 10:48:53AM +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function sun4i_hash()
> in the error handling case.
> 
> Fixes: 477d9b2e591b ("crypto: sun4i-ss - unify update/final function")
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
