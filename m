From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Nov 2016 17:50:42 +0000
Subject: [PATCHv2 00/11] arm64: move thread_info off of the task stack
In-Reply-To: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
References: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20161114175042.GF3096@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 08:23:02PM +0000, Mark Rutland wrote:
> Mark Rutland (11):
>   arm64: thread_info remove stale items
>   arm64: asm-offsets: remove unused definitions
>   arm64: factor out current_stack_pointer
>   arm64: traps: simplify die() and __die()
>   arm64: unexport walk_stackframe
>   arm64: prep stack walkers for THREAD_INFO_IN_TASK
>   arm64: move sp_el0 and tpidr_el1 into cpu_suspend_ctx
>   arm64: smp: prepare for smp_processor_id() rework
>   arm64: make cpu number a percpu variable
>   arm64: assembler: introduce ldr_this_cpu
>   arm64: split thread_info from task stack

I queued these patches for 4.10, together with the two on
core-ti-stack-split (subject to more testing).

Thanks.

-- 
Catalin
