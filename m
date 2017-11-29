From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 29 Nov 2017 17:30:28 +1100
Subject: [v2,01/12] hwrng: bcm2835 - Obtain base register via resource
In-Reply-To: <20171108004449.32730-2-f.fainelli@gmail.com>
References: <20171108004449.32730-2-f.fainelli@gmail.com>
Message-ID: <20171129063028.GB21594@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 04:44:38PM -0800, Florian Fainelli wrote:
> In preparation for consolidating bcm63xx-rng into bcm2835-rng, make sure
> that we obtain the base register via platform_get_resource() since we
> need to support the non-DT enabled MIPS-based BCM63xx DSL SoCs.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
