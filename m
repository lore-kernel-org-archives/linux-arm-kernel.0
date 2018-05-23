From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 May 2018 11:47:09 +0100
Subject: [PATCH 0/2] arm64: fatal kernel fault reporting improvements
In-Reply-To: <20180521131451.41040-1-mark.rutland@arm.com>
References: <20180521131451.41040-1-mark.rutland@arm.com>
Message-ID: <20180523104708.ygwt3gainhxkx2km@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 02:14:49PM +0100, Mark Rutland wrote:
> Catalin noticed that do_page_fault() can die() for some faults without
> reporting the faulting address, which is unfortunate. We also don't
> decode the ESR, or attempt to dump the page tables.
> 
> These patches unify the handling of those faults with the ones we handle
> in __do_kernel_fault(), making things a little more consistent.
> 
> Thanks,
> Mark.
> 
> Mark Rutland (2):
>   arm64: make is_permission_fault() name clearer
>   arm64: Unify kernel fault reporting

Queued for 4.18. Thanks.

-- 
Catalin
