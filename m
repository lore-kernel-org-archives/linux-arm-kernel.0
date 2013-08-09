From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 9 Aug 2013 16:42:34 +1000
Subject: [PATCH 0/6] hwrng: OMAP: Updates for OMAP RNG module
In-Reply-To: <1375714043-23407-1-git-send-email-lokeshvutla@ti.com>
References: <1375714043-23407-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20130809064234.GB23834@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 08:17:17PM +0530, Lokesh Vutla wrote:
> This patch series adds support for OMAP4 version of RNG module.
> This module produce a 64 bit random number and also allows to
> de tune FROs when repeated pattern is coming out of FROs.
> This series also has few fixes for the driver.
> 
> Lokesh Vutla (6):
>   hwrng: OMAP: Use module_platform_driver macro
>   hwrng: OMAP: Convert to devm_kzalloc()
>   hwrng: OMAP: Remove duplicated function call
>   hwrng: OMAP: Add device tree support
>   ARM: OMAP2+: Only manually add hwmod data when DT not used.
>   hwrng: OMAP: Add OMAP4 TRNG support

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
