From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Sep 2012 22:30:45 -0700
Subject: [GIT PULL V2 1/4] ARM: Kirkwood: DT bindings for v3.7
In-Reply-To: <20120910054835.GC15277@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120910054835.GC15277@titan.lakedaemon.net>
Message-ID: <20120913053045.GB24290@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 01:48:35AM -0400, Jason Cooper wrote:
> Arnd, Olof,
> 
> This branch depends on arm/cache-l2x0 which is going in through rmk's
> tree.  arm/cache-l2x0 contains the following from Gregory Clement:
> 
> 	arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
> 	arm: cache-l2x0: add an optional register to save/restore

Ok, we need to make sure that Russell is happy with the patches and
is pulling them in (with an agreement to not rebase the merged branch)
before we can pull in your branch that builds on it.

Russell, please let us know if/when that's the case so we can merge in the
dependent code.

Thanks!


-Olof
