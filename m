From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 13 Aug 2015 15:16:26 +0800
Subject: [PATCH 0/3] ARM: sun6i: Support Security System crypto engine
In-Reply-To: <1439271177-26523-1-git-send-email-wens@csie.org>
References: <1439271177-26523-1-git-send-email-wens@csie.org>
Message-ID: <20150813071626.GA21239@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 01:32:54PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series enables support for the crypto engine found in sun6i, or
> Allwinner A31/A31s SoCs. The crypto engine is the same hardware as on
> earlier sun4i/sun7i (A10/A20), with the only difference being the reset
> control is separated out of the clock gate control.
> 
> The same hardware is also available on the A33, but not the A23. Support
> for this requires additions to the clock driver, and will be submitted
> separately once things are clear on how to proceed. I already have a
> proof of concept working.
> 
> 
> Patch 1 adds an optional reset control property to the sunxi-ss binding.
> 
> Patch 2 adds optional reset control support to the sunxi-ss driver.
> 
> Patch 3 enables the crypto engine on sun6i, by adding the module clock and
> device node.

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
