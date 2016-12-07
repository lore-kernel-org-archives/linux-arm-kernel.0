From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 7 Dec 2016 13:51:27 +0100
Subject: [PATCH v2] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <20161207120900.GC20680@gondor.apana.org.au>
References: <1480934922-20732-1-git-send-email-clabbe.montjoie@gmail.com>
 <20161205123705.GA10732@gondor.apana.org.au>
 <20161205125738.GA13525@Red>
 <20161207120900.GC20680@gondor.apana.org.au>
Message-ID: <20161207125127.GB28218@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 08:09:00PM +0800, Herbert Xu wrote:
> On Mon, Dec 05, 2016 at 01:57:38PM +0100, Corentin Labbe wrote:
> >
> > So how to expose PRNG to user space ? or more generally how to "use" a PRNG ?
> 
> We do have the algif_rng interface.
> 

So I must expose it as a crypto_rng ?

Could you explain why PRNG must not be used as hw_random ?

Regards
Corentin Labbe
