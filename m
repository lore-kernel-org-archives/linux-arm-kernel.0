From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 2 Mar 2015 23:23:49 +1300
Subject: [PATCH v2 0/2] Add support for Broadcom RNG200
In-Reply-To: <1424888184-22180-1-git-send-email-sbranden@broadcom.com>
References: <sbranden@broadcom.com>
 <1424888184-22180-1-git-send-email-sbranden@broadcom.com>
Message-ID: <20150302102348.GA24294@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 10:16:22AM -0800, Scott Branden wrote:
> This series of patchsets contains the Broadcom Random Number Generator
> driver and device tree binding documentation.
> 
> Changes from v1:
>  added \n to 2 dev_err messages

If you want this to go through the crypto tree please add a cc
to linux-crypto at vger.kernel.org.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
