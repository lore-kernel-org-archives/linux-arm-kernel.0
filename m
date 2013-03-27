From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Mar 2013 10:36:23 +0000
Subject: [PATCH 2/4] ARM: tlb: don't perform inner-shareable invalidation
 for local BP ops
In-Reply-To: <1364235581-17900-3-git-send-email-will.deacon@arm.com>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-3-git-send-email-will.deacon@arm.com>
Message-ID: <20130327103622.GC801@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:19:39PM +0000, Will Deacon wrote:
> Now that the ASID allocator doesn't require inner-shareable maintenance,
> we can convert the local_bp_flush_all function to perform only
> non-shareable flushing, in a similar manner to the TLB invalidation
> routines.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
