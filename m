From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 14 Dec 2016 13:05:51 +0800
Subject: [PATCH v2] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <20161213141059.GB10647@Red>
References: <1480934922-20732-1-git-send-email-clabbe.montjoie@gmail.com>
 <20161205123705.GA10732@gondor.apana.org.au>
 <20161205125738.GA13525@Red>
 <20161207120900.GC20680@gondor.apana.org.au>
 <20161207125127.GB28218@Red>
 <20161208090618.GB22932@gondor.apana.org.au>
 <20161213141059.GB10647@Red>
Message-ID: <20161214050551.GD9592@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 03:10:59PM +0100, Corentin Labbe wrote:
>
> I have found two solutions:

No we already have algif_rng so let's not confuse things even
further by making hwrng take PRNGs.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
