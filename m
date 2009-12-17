From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2009 10:51:36 +0000
Subject: [PATCH V2 1/2] arm nomadik: add hardware RNG driver
In-Reply-To: <20091217084256.GB28801@gondor.apana.org.au>
References: <20091211061526.GA28849@gondor.apana.org.au>
	<376a2243795aadfb87c8a7f5ea039.1260011962.git.rubini@unipv.it>
	<20091205185646.GQ8789@waste.org>
	<20091217083623.GA16218@morgana.gnudd.com>
	<20091217084256.GB28801@gondor.apana.org.au>
Message-ID: <20091217105136.GA1959@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 04:42:56PM +0800, Herbert Xu wrote:
> On Thu, Dec 17, 2009 at 09:36:24AM +0100, Alessandro Rubini wrote:
> > >> Acked-by: Matt Mackall <mpm@selenic.com>
> > > Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> > 
> > So, what should my next step? I don't find the patch in any tree.
> > Russell, should I put those two in your patch system?
> 
> Well I'm happy to pick these up as long as Russell is OK with
> them.  I wanted to hear from him as the second patch touches
> the ARM tree.

It shouldn't be a problem unless there ends up being conflicting changes
in that file.  Currently there are none.
