From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 29 Nov 2016 17:07:41 +0800
Subject: [PATCH v2 0/6] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <6b83ea5d-a465-7582-a215-51a21fb4ce2e@suse.cz>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
 <6b83ea5d-a465-7582-a215-51a21fb4ce2e@suse.cz>
Message-ID: <20161129090739.GC16569@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 03:20:05PM +0100, Vlastimil Babka wrote:
> > Huang Shijie (6):
> >   mm: hugetlb: rename some allocation functions
> >   mm: hugetlb: add a new parameter for some functions
> >   mm: hugetlb: change the return type for alloc_fresh_gigantic_page
> >   mm: mempolicy: intruduce a helper huge_nodemask()
> >   mm: hugetlb: add a new function to allocate a new gigantic page
> >   mm: hugetlb: support gigantic surplus pages
> > 
> >  include/linux/mempolicy.h |   8 +++
> >  mm/hugetlb.c              | 128 ++++++++++++++++++++++++++++++++++++----------
> >  mm/mempolicy.c            |  20 ++++++++
> >  3 files changed, 130 insertions(+), 26 deletions(-)
> 
> Can't say I'm entirely happy with the continued direction of maze of
> functions for huge page allocation :( Feels like path of least resistance to
> basically copy/paste the missing parts here. Is there no way to consolidate
> the code more?
Ok, I will spend some time to read the code and think about it.

If you have interest, please do it too. :)

Thanks
Huang Shijie
