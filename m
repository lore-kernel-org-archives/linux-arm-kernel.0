From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 6 Mar 2015 22:53:48 +1100
Subject: [PATCH v3 0/2] Add support for Broadcom RNG200
In-Reply-To: <1425501734-14025-1-git-send-email-sbranden@broadcom.com>
References: <sbranden@broadcom.com>
 <1425501734-14025-1-git-send-email-sbranden@broadcom.com>
Message-ID: <20150306115348.GA5363@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 12:42:12PM -0800, Scott Branden wrote:
> This series of patchsets contains the Broadcom Random Number Generator
> driver and device tree binding documentation.
> 
> Changes from v2:
>  added usleep_range instead of cpu_relax
>  add init and cleanup functions following new hwrng model

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
