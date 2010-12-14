From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Wed, 15 Dec 2010 08:50:47 +0900
Subject: [PATCHv7 08/10] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <87zks8fyb0.fsf@erwin.mina86.com>
References: <cover.1292004520.git.m.nazarewicz@samsung.com>
	<fc8aa07ac71d554ba10af4943fdb05197c681fa2.1292004520.git.m.nazarewicz@samsung.com>
	<20101214102401.37bf812d.kamezawa.hiroyu@jp.fujitsu.com>
	<87zks8fyb0.fsf@erwin.mina86.com>
Message-ID: <20101215085047.251778be.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Dec 2010 11:23:15 +0100
Michal Nazarewicz <mina86@mina86.com> wrote:

> > Hmm, it seems __cm_alloc() and __cm_migrate() has no special codes for CMA.
> > I'd like reuse this for my own contig page allocator.
> > So, could you make these function be more generic (name) ?
> > as
> > 	__alloc_range(start, size, mirate_type);
> >
> > Then, what I have to do is only to add "search range" functions.
> 
> Sure thing.  I'll post it tomorrow or Friday. How about
> alloc_contig_range() maybe?
> 

That sounds great. Thank you.

-Kame
