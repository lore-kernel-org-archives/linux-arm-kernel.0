From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 17 Aug 2017 16:46:08 +0800
Subject: [RFC PATCH 00/10] crypto: caam - add DPAA2 (DPSECI) driver
In-Reply-To: <20170810174253.20951-1-horia.geanta@nxp.com>
References: <20170810174253.20951-1-horia.geanta@nxp.com>
Message-ID: <20170817084607.GA25429@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 08:42:43PM +0300, Horia Geant? wrote:
>
> Patches 5-9 are the core of the patch set, adding the driver.
> For symmetric encryption the legacy ablkcipher interface is used; the
> plan is to convert to skcipher all CAAM frontends at once at a certain
> point in time.

I'm fine with these patches.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
