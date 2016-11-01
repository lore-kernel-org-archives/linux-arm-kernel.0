From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 1 Nov 2016 08:44:59 +0800
Subject: [PATCH v3] char: hw_random: atmel-rng: disable TRNG during suspend
In-Reply-To: <1477641646-30796-1-git-send-email-wenyou.yang@atmel.com>
References: <1477641646-30796-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20161101004458.GE7375@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 04:00:46PM +0800, Wenyou Yang wrote:
> To fix the over consumption on the VDDCore due to the TRNG enabled,
> disable the TRNG during suspend, not only disable the user interface
> clock (which is controlled by PMC). Because the user interface clock
> is independent from any clock that may be used in the entropy source
> logic circuitry.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
