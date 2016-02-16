From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 16 Feb 2016 20:21:36 +0000
Subject: [PATCH 0/2] crypto: atmel-sha - fix .import()/.export()
 implementation
In-Reply-To: <cover.1454944687.git.cyrille.pitchen@atmel.com>
References: <cover.1454944687.git.cyrille.pitchen@atmel.com>
Message-ID: <20160216202136.GG11908@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 04:26:47PM +0100, Cyrille Pitchen wrote:
> This series of patches includes two fixes for the atmel-sha.c driver.
> 
> The first one fixes the implementation of the import/export hooks, which
> did not pass the recent updates in testmgr.c (partial update exercise).
> The new implementation now passes the tcrypt tests: tested with
> next-20160208.
> 
> The second patch fixes a race condition if acquiring the hardware when it
> is already busy.

All applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
