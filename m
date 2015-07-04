From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 4 Jul 2015 15:37:17 +0800
Subject: crypto: marvell/CESA: Issues with non cache-line aligned buffers
In-Reply-To: <20150704073355.GA6451@gondor.apana.org.au>
References: <20150703114305.15611807@bbrezillon>
 <20150704073355.GA6451@gondor.apana.org.au>
Message-ID: <20150704073717.GA6539@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 04, 2015 at 03:33:55PM +0800, Herbert Xu wrote:
> Note that I don't think we have a suitable helper for DMA-aligned
> processing of SG lists.  The ablkcipher_walk_* interface is mostly
> identical to the blkcipher_walk_* interface.

Actually I take that back.  The ablkcipher_walk_* should work
even if may be a bit unwieldy.  Patches to improve it are of
course welcome :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
