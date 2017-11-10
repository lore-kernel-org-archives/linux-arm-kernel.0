From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 10 Nov 2017 22:36:25 +1100
Subject: [PATCH 0/2] hwrng: iproc-rng200: Add support for BCM7278
In-Reply-To: <20171101232006.3943-1-f.fainelli@gmail.com>
References: <20171101232006.3943-1-f.fainelli@gmail.com>
Message-ID: <20171110113625.GA26163@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 04:20:04PM -0700, Florian Fainelli wrote:
> Hi,
> 
> This patch series adds support for the RNG200 block found on the BCM7278 SoC.
> This requires us to update the compatible string (and associated binding
> document) as well as the Kconfig option to make that driver selectable with
> ARCH_BRCMSTB gating the enabling of such SoCs.
> 
> Thank you
> 
> Florian Fainelli (2):
>   dt-bindings: rng: Document BCM7278 RNG200 compatible
>   hwrng: iproc-rng200: Add support for BCM7278

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
