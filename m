From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 16:27:44 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120509152827.GA3955@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205091503.22950.arnd@arndb.de>
 <20120509152827.GA3955@opensource.wolfsonmicro.com>
Message-ID: <201205091627.44250.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Mark Brown wrote:
>   Show Details
>   On Wed, May 09, 2012 at 03:03:22PM +0000, Arnd Bergmann wrote:
> 
> > I mean that each device providing resources of the new type would need
> > to register its resources to the same root resource with non-conclicting
> 
> Oh, right - I see what you mean.  I was thinking of creating a
> per-chip parent for each tree rather than trying to make them a unified
> tree, though I guess it's useful for diagnostics.  Multi-level resources
> might be slightly fun with this though I'm not sure how realistic they
> are.

Well, as Russell just pointed out, that's not actually a requirement,
so we probably don't want to do that after all.

	Arnd
