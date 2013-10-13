From: tj@kernel.org (Tejun Heo)
Date: Sun, 13 Oct 2013 15:54:06 -0400
Subject: [RFC 09/23] mm/init: Use memblock apis for early memory
 allocations
In-Reply-To: <1381615146-20342-10-git-send-email-santosh.shilimkar@ti.com>
References: <1381615146-20342-1-git-send-email-santosh.shilimkar@ti.com>
 <1381615146-20342-10-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131013195406.GC18075@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 12, 2013 at 05:58:52PM -0400, Santosh Shilimkar wrote:
> Switch to memblock interfaces for early memory allocator

When posting actual (non-RFC) patches later, please cc the maintainers
of the target subsystem and briefly explain why the new interface is
needed and that this doesn't change visible behavior.

Thanks.

-- 
tejun
