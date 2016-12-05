From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 5 Dec 2016 20:37:05 +0800
Subject: [PATCH v2] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <1480934922-20732-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1480934922-20732-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20161205123705.GA10732@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 11:48:42AM +0100, Corentin Labbe wrote:
> From: LABBE Corentin <clabbe.montjoie@gmail.com>
> 
> The Security System have a PRNG.
> This patch add support for it as an hwrng.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Please don't add PRNGs to hwrng.  If we have existing PRNGs in
there please let me know so that we can remove them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
