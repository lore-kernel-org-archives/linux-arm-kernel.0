From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 10 Aug 2013 17:38:18 +0200 (CEST)
Subject: [PATCH] arch/arm/mach-pxa/stargate2.c: use ARRAY_AND_SIZE
 consistently
In-Reply-To: <1376148738.2083.17.camel@joe-AO722>
References: <1376148353-9699-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376148738.2083.17.camel@joe-AO722>
Message-ID: <alpine.DEB.2.02.1308101735060.2076@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sat, 10 Aug 2013, Joe Perches wrote:

> On Sat, 2013-08-10 at 17:25 +0200, Julia Lawall wrote:
> > From: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > Because ARRAY_AND_SIZE changes the apparent arity of a function, if it is
> > used for one call to a given function, it would be better, if possible, to
> > use it for all of them.
> 
> I think it'd be better to remove ARRAY_AND_SIZE instead.

I can do that, if it is wanted, but there are over 200 uses, and I think 
it is a little bit positive in that it ensures that the array is passed 
along with its own size.

julia
