From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 11 Dec 2009 14:15:26 +0800
Subject: [PATCH V2 1/2] arm nomadik: add hardware RNG driver
In-Reply-To: <20091205185646.GQ8789@waste.org>
References: <376a2243795aadfb87c8a7f5ea039.1260011962.git.rubini@unipv.it>
	<20091205185646.GQ8789@waste.org>
Message-ID: <20091211061526.GA28849@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 05, 2009 at 12:56:46PM -0600, Matt Mackall wrote:
> On Sat, Dec 05, 2009 at 12:31:28PM +0100, Alessandro Rubini wrote:
> > From: Alessandro Rubini <rubini@unipv.it>
> > 
> > The hardware random number generator by ST is used in both the Nomadik
> > 8815 SoC and the U8500. It returns 16 bits every 400ns with automatic
> > delay if a read is issued too early. It depends on PLAT_NOMADIK.
> > 
> > Signed-off-by: Alessandro Rubini <rubini@unipv.it>
> > Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
> 
> Looks good to me.
> 
> Acked-by: Matt Mackall <mpm@selenic.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
