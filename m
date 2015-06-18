From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 18 Jun 2015 15:02:59 +0800
Subject: [PATCH v6 06/14] crypto: marvell/CESA: add DES support
In-Reply-To: <20150618085709.2180759d@bbrezillon>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434527142-3609-7-git-send-email-boris.brezillon@free-electrons.com>
 <20150618085709.2180759d@bbrezillon>
Message-ID: <20150618070259.GA28882@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 08:57:09AM +0200, Boris Brezillon wrote:
> Hi Herbert,
> 
> On Wed, 17 Jun 2015 09:45:34 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> > Add support for DES operations.
> 
> The addition of DES support seems controversial. At first I thought it
> would be good to support all the algorithms supported by the CESA
> engine, but I think I'll drop it in the next iteration.
> 
> Do you think Triple-DES should be dropped too ?

We're not here to make policy decisions.  So I don't see anything
wrong with keeping it.  However, if you don't wish to add it then
it's fine by me too.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
