From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 1 Jan 2014 14:06:51 +0800
Subject: [ARM] Fix kernel compile error: drivers/crypto/ixp4xx_crypto.c.
In-Reply-To: <m3d2kduwd7.fsf@t19.piap.pl>
References: <m3d2kduwd7.fsf@t19.piap.pl>
Message-ID: <20140101060651.GA22534@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 31, 2013 at 11:51:16AM +0100, Krzysztof Ha?asa wrote:
> drivers/crypto/ixp4xx_crypto.c: In function 'ixp_module_init':
> drivers/crypto/ixp4xx_crypto.c:1419:2: error: 'dev' undeclared (first use in this function)
> 
> Now builds. Not tested on real hw.
> 
> Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
