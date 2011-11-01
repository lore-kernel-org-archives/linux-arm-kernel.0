From: mel@csn.ul.ie (Mel Gorman)
Date: Tue, 1 Nov 2011 18:47:59 +0000
Subject: [PATCH 2/9] mm: alloc_contig_freed_pages() added
In-Reply-To: <op.v394luhl3l0zgt@mpn-glaptop>
References: <20111018122109.GB6660@csn.ul.ie>
	<809d0a2afe624c06505e0df51e7657f66aaf9007.1319428526.git.mina86@mina86.com>
	<20111101150448.GD14998@csn.ul.ie> <op.v394luhl3l0zgt@mpn-glaptop>
Message-ID: <20111101184759.GE14998@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2011 at 07:06:56PM +0100, Michal Nazarewicz wrote:
> >page_isolation.c may also be a better fit than page_alloc.c
> 
> Since isolate_freepages_block() is the only user of split_free_page(),
> would it make sense to move split_free_page() to page_isolation.c as
> well?  I sort of like the idea of making it static and removing from
> header file.
> 

I see no problem with that. It'll be separate from split_page() but that
is not earth shattering.

Thanks.

-- 
Mel Gorman
SUSE Labs
