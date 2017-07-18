From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 18 Jul 2017 18:36:26 +0800
Subject: [PATCH] crypto: mediatek: fix error return code in
 mtk_crypto_probe()
In-Reply-To: <20170630062454.GA9699@embeddedgus>
References: <20170630062454.GA9699@embeddedgus>
Message-ID: <20170718103626.GJ6479@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 01:24:54AM -0500, Gustavo A. R. Silva wrote:
> Propagate the return value of platform_get_irq on failure.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
