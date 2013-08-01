From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 1 Aug 2013 11:47:41 +1000
Subject: [PATCH 0/4] crypto: omap-sham: Add support for SHA384/SHA512 for
 OMAP5/AM43xx Soc's
In-Reply-To: <1374821957-30141-1-git-send-email-lokeshvutla@ti.com>
References: <1374821957-30141-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20130801014741.GE24286@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 12:29:13PM +0530, Lokesh Vutla wrote:
> This patch series adds support for SHA348 and SHA512 in addition to MD5,
> SHA1, SHA224 SHA256 that the omap sha module supports. Also adding the pdata
> for OMAP5 and AM43xx Soc's.
> And using devm_* calls to make cleanup paths simpler.

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
