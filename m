From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 30 Aug 2012 13:29:25 -0700
Subject: [PATCH 0/5] hwrng/ARM: OMAP: convert to use runtime PM
In-Reply-To: <20120830202708.GZ1303@atomide.com>
References: <20120827232922.15045.56522.stgit@dusk.lan>
 <20120830202708.GZ1303@atomide.com>
Message-ID: <20120830202925.GA32300@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 01:27:08PM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [120827 16:39]:
> > This series converts the OMAP hardware random number generator driver
> > to use runtime PM.  Hardware integration data is added for OMAP2xxx
> > systems.  I'm pretty sure this device is available on other OMAP chips
> > too, but may require some experimentation with the integration details.
> 
> Good to hear. I believe that at some point this got moved to be
> only accessible in the secure mode on later omaps?
>  
> > There are still a few rough edges with this series.  Something is
> > still not right with the reset behavior on OMAP2430, at least.  But it
> > would be good to get acks from the hwrng folks for the three patches that
> > touch files in that directory.  Will continue with the testing process
> > here.
> 
> Yes Matt & Herbert, care to ack the drivers/char/hw_random related changes?

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

> This series will conflict with the planned ARM common zImage changes
> that we have planned so I'd like to merge them via the ARM soc tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
