From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 5 Dec 2016 13:57:38 +0100
Subject: [PATCH v2] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <20161205123705.GA10732@gondor.apana.org.au>
References: <1480934922-20732-1-git-send-email-clabbe.montjoie@gmail.com>
 <20161205123705.GA10732@gondor.apana.org.au>
Message-ID: <20161205125738.GA13525@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 08:37:05PM +0800, Herbert Xu wrote:
> On Mon, Dec 05, 2016 at 11:48:42AM +0100, Corentin Labbe wrote:
> > From: LABBE Corentin <clabbe.montjoie@gmail.com>
> > 
> > The Security System have a PRNG.
> > This patch add support for it as an hwrng.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Please don't add PRNGs to hwrng.  If we have existing PRNGs in
> there please let me know so that we can remove them.
> 

So how to expose PRNG to user space ? or more generally how to "use" a PRNG ?

I found hisi-rng, crypto4xx_ and exynos-rng which seems to be PRNG used as hwrng.

Regards
