From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 30 Sep 2013 10:30:15 +0100
Subject: [PATCH] ARM: l2x0: protect outer_cache_fns.sync pointer
 assignment with OUTER_CACHE_SYNC
In-Reply-To: <1380473513.19674.YahooMailNeo@web161602.mail.bf1.yahoo.com>
References: <1379861550.88310.YahooMailNeo@web161601.mail.bf1.yahoo.com>
 <20130926131207.GA3467@darko.cambridge.arm.com>
 <1380473513.19674.YahooMailNeo@web161602.mail.bf1.yahoo.com>
Message-ID: <20130930093014.GC17042@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 05:51:53PM +0100, Eran Ben-Avi wrote:
> [PATCH] ARM: l2x0: define l2x0_cache_sync according to OUTER_CACHE_SYNC selection
> 
> ??? Always define outer_cache_fns sync member and conditionally assign
> ??? l2x0_cache_sync depends on OUTER_CACHE_SYNC selection state.
> 
> Signed-off-by: Eran Ben-Avi <benavi@marvell.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
