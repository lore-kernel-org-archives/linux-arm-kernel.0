From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 10 Jun 2017 12:16:17 +0800
Subject: [PATCH v6 4/5] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <20170524141035.21031-5-antoine.tenart@free-electrons.com>
References: <20170524141035.21031-1-antoine.tenart@free-electrons.com>
 <20170524141035.21031-5-antoine.tenart@free-electrons.com>
Message-ID: <20170610041617.GD14719@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 04:10:34PM +0200, Antoine Tenart wrote:
> Add support for Inside Secure SafeXcel EIP197 cryptographic engine,
> which can be found on Marvell Armada 7k and 8k boards. This driver
> currently implements: ecb(aes), cbc(aes), sha1, sha224, sha256 and
> hmac(sah1) algorithms.
> 
> Two firmwares are needed for this engine to work. Their are mostly used
> for more advanced operations than the ones supported (as of now), but we
> still need them to pass the data to the internal cryptographic engine.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
