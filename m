From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Jul 2014 16:01:54 +0200
Subject: [PATCH] crypto: ux500: make interrupt mode plausible
In-Reply-To: <20140703134400.GC14291@gondor.apana.org.au>
References: <13720857.JmA1VNKFj8@wuerfel>
 <20140703134400.GC14291@gondor.apana.org.au>
Message-ID: <6058264.NMWsAerSr1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 July 2014 21:44:00 Herbert Xu wrote:
> 
> > The bug has existed since the driver was first merged, and was
> > probably never detected because nobody tried to use interrupt mode.
> > It might make sense to backport this fix to stable kernels, depending
> > on how the crypto maintainers feel about that.
> 
> Patch applied.  I'm not going to push this to stable though until
> I see some more testing.  We can always push this later if needed.

Sounds good, thanks!

	Arnd
