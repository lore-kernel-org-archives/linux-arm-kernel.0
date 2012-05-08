From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 8 May 2012 20:00:58 +1000
Subject: linux-next: manual merge of the arm-soc tree with the crypto tree
In-Reply-To: <20120508172153.b05c9d198b1b81c652a2bde6@canb.auug.org.au>
References: <20120508172153.b05c9d198b1b81c652a2bde6@canb.auug.org.au>
Message-ID: <20120508100058.GB2113@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 05:21:53PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/char/hw_random/Kconfig between commit 028fdd87b79a ("hwrng:
> Kconfig - modify default state for atmel-rng driver") from the crypto
> tree and commit 1234f4bada54 ("hwrng: Kconfig: remove dependency for
> atmel-rng driver") from the arm-soc tree.
> 
> Juts context changes.  I fixed it up (see below) and can carry the fix as
> necessary.

Looks good.  Thanks Stephen!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
