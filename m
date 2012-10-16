From: minchan@kernel.org (Minchan Kim)
Date: Tue, 16 Oct 2012 22:12:28 +0900
Subject: [PATCH] mm: compaction: Correct the nr_strict_isolated check for
 CMA
In-Reply-To: <20121016083927.GG29125@suse.de>
References: <20121016083927.GG29125@suse.de>
Message-ID: <20121016131228.GB5603@barrios>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 09:39:27AM +0100, Mel Gorman wrote:
> Thierry reported that the "iron out" patch for isolate_freepages_block()
> had problems due to the strict check being too strict with "mm: compaction:
> Iron out isolate_freepages_block() and isolate_freepages_range() -fix1".
> It's possible that more pages than necessary are isolated but the check
> still fails and I missed that this fix was not picked up before RC1. This
> same problem has been identified in 3.7-RC1 by Tony Prisk and should be
> addressed by the following patch.
> 
> Signed-off-by: Mel Gorman <mgorman@suse.de>
> Tested-by: Tony Prisk <linux@prisktech.co.nz>
Acked-by: Minchan Kim <minchan@kernel.org>

-- 
Kind Regards,
Minchan Kim
