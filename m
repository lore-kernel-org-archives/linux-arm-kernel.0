From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 7 Dec 2016 20:09:00 +0800
Subject: [PATCH v2] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <20161205125738.GA13525@Red>
References: <1480934922-20732-1-git-send-email-clabbe.montjoie@gmail.com>
 <20161205123705.GA10732@gondor.apana.org.au>
 <20161205125738.GA13525@Red>
Message-ID: <20161207120900.GC20680@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 01:57:38PM +0100, Corentin Labbe wrote:
>
> So how to expose PRNG to user space ? or more generally how to "use" a PRNG ?

We do have the algif_rng interface.

> I found hisi-rng, crypto4xx_ and exynos-rng which seems to be PRNG used as hwrng.

Thanks for checking.  Patches to remove these are welcome.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
