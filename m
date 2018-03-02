From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 3 Mar 2018 00:42:02 +0800
Subject: [PATCH] crypto: marvell/cesa - Clean up redundant #include
In-Reply-To: <99d8deb60039adf572aec26b091f2b0c61edf397.1519048413.git.robin.murphy@arm.com>
References: <99d8deb60039adf572aec26b091f2b0c61edf397.1519048413.git.robin.murphy@arm.com>
Message-ID: <20180302164202.GD21579@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 01:55:36PM +0000, Robin Murphy wrote:
> The inclusion of dma-direct.h was only needed temporarily to prevent
> breakage from the DMA API rework, since the actual CESA fix making it
> redundant was merged in parallel. Now that both have landed, it can go.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
