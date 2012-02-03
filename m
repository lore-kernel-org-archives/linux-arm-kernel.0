From: mel@csn.ul.ie (Mel Gorman)
Date: Fri, 3 Feb 2012 14:09:02 +0000
Subject: [PATCHv20 00/15] Contiguous Memory Allocator
In-Reply-To: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120203140902.GH5796@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 01:18:43PM +0100, Marek Szyprowski wrote:
> Welcome everyone again!
> 
> This is yet another quick update on Contiguous Memory Allocator patches.
> This version includes another set of code cleanups requested by Mel
> Gorman and a few minor bug fixes. I really hope that this version will
> be accepted for merging and future development will be handled by
> incremental patches.

FWIW, I've acked all I'm going to ack of this series and made some
suggestions on follow-ups on the core MM parts that could be done
in-tree. I think the current reclaim logic is going to burn CMA with
race conditions but it is a CMA-specific problem so watch out for
that :)

As before, I did not even look at the CMA driver itself or the
arch-specific parts. I'm assuming Arnd has that side of things covered.

Thanks Marek.

-- 
Mel Gorman
SUSE Labs
