From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jan 2014 15:43:21 +0000
Subject: [Q] L1_CACHE_BYTES on flush_pfn_alias function.
In-Reply-To: <00d501cf136a$24ec49c0$6ec4dd40$@samsung.com>
References: <00d501cf136a$24ec49c0$6ec4dd40$@samsung.com>
Message-ID: <20140124154321.GI19052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 09:54:42AM +0000, ?????? wrote:
> Follow the mailing-list
> http://comments.gmane.org/gmane.linux.ports.arm.omap/31686
> 
> >>Setting the L1 cache line size larger than it actually is should be safe.
> 
> the written code expected as L1_CACHE_BYTES should be real cache line size
> has bug.
> It looks like that flush_pfn_alias function should be fixed.

Did you actually notice any problem with flushing some more bytes? It's
a clean+invalidate rather than invalidate, I don't see any problem.

-- 
Catalin
