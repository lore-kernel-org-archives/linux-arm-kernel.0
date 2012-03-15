From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 16 Mar 2012 10:54:06 +1100
Subject: [PATCH 6/6] hwrng: Kconfig: remove dependency for atmel-rng driver
In-Reply-To: <c3455cec019bedacc6ff58cf8cd2ae25cdeb212f.1331826095.git.nicolas.ferre@atmel.com>
References: <cover.1331826095.git.nicolas.ferre@atmel.com>
 <c3455cec019bedacc6ff58cf8cd2ae25cdeb212f.1331826095.git.nicolas.ferre@atmel.com>
Message-ID: <20120315235406.GB18496@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 04:57:22PM +0100, Nicolas Ferre wrote:
> This will allow to select this driver for newer SoCs. Make sure to
> keep dependency on HAVE_CLK to avoid breaking other machines.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
