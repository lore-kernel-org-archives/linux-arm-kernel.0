From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 30 Apr 2012 20:02:23 +1000
Subject: [PATCH] hwrng: Kconfig: modify default state for atmel-rng driver
In-Reply-To: <20120430095511.GC3170@opensource.wolfsonmicro.com>
References: <20120427173504.GK18260@opensource.wolfsonmicro.com>
 <1335779353-9515-1-git-send-email-nicolas.ferre@atmel.com>
 <20120430095511.GC3170@opensource.wolfsonmicro.com>
Message-ID: <20120430100223.GA32204@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 10:55:12AM +0100, Mark Brown wrote:
> On Mon, Apr 30, 2012 at 11:49:13AM +0200, Nicolas Ferre wrote:
> > In order to prevent building the Atmel hw_random driver for each and every
> > configuration, add a "default" Kconfig state in relation with
> > CONFIG_ARCH_AT91.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
