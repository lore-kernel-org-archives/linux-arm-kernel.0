From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 12:15:24 +0100
Subject: [PATCH v2 02/20] documentation: Clarify failed cmpxchg memory
 ordering semantics
In-Reply-To: <1437734531-10698-3-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-3-git-send-email-will.deacon@arm.com>
Message-ID: <20150724111524.GC3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:53AM +0100, Will Deacon wrote:
> A failed cmpxchg does not provide any memory ordering guarantees, a
> property that is used to optimise the cmpxchg implementations on Alpha,
> PowerPC and arm64.
> 
> This patch updates atomic_ops.txt and memory-barriers.txt to reflect
> this.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
