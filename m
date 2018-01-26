From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 26 Jan 2018 23:45:24 +0800
Subject: [PATCH -next] hwrng: bcm2835 - Remove redundant dev_err call in
 bcm2835_rng_probe()
In-Reply-To: <1516189234-11957-1-git-send-email-weiyongjun1@huawei.com>
References: <1516189234-11957-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180126154524.GF4002@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 11:40:34AM +0000, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
