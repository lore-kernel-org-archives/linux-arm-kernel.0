From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 13 Jan 2017 22:37:09 +0800
Subject: [PATCH -next] crypto: mediatek - make symbol of_crypto_id static
In-Reply-To: <20170112150321.4187-1-weiyj.lk@gmail.com>
References: <20170112150321.4187-1-weiyj.lk@gmail.com>
Message-ID: <20170113143709.GA26101@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 03:03:21PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/crypto/mediatek/mtk-platform.c:585:27: warning:
>  symbol 'of_crypto_id' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
