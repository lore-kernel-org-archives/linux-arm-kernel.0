From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 25 Jan 2016 15:25:13 +0800
Subject: [PATCH 0/5] crypto: atmel-sha: fix registration issue and other
 bugs
In-Reply-To: <56A25E5D.6050504@atmel.com>
References: <cover.1452867917.git.cyrille.pitchen@atmel.com>
 <56A25E5D.6050504@atmel.com>
Message-ID: <20160125072513.GD5609@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 05:52:45PM +0100, Nicolas Ferre wrote:
> Le 15/01/2016 15:49, Cyrille Pitchen a ?crit :
> > Hi all,
> > 
> > This series of patches fixes many issues such as the algo registration failure
> > or the broken support of context switches.
> 
> I think it's eligible as a "fixes" series for 4.5... Herbert, is the
> whole series can be queued as fixes, in your opinion?

Sorry, but I'd prefer to postpone this til the next cycle as it
came in too close to the cut-off mark.  This code is directly
accessible by unprivileged users so I'd like it to cook for a
bit longer.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
