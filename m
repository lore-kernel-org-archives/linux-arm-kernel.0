From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Oct 2015 11:59:35 +0100
Subject: [PATCH v2 00/10] arm64 switch_mm improvements
In-Reply-To: <1444153590-24173-1-git-send-email-will.deacon@arm.com>
References: <1444153590-24173-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151007105934.GA875@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 06:46:20PM +0100, Will Deacon wrote:
> Will Deacon (10):
>   arm64: mm: remove unused cpu_set_idmap_tcr_t0sz function
>   arm64: proc: de-scope TLBI operation during cold boot
>   arm64: flush: use local TLB and I-cache invalidation
>   arm64: mm: rewrite ASID allocator and MM context-switching code
>   arm64: tlbflush: remove redundant ASID casts to (unsigned long)
>   arm64: tlbflush: avoid flushing when fullmm == 1
>   arm64: switch_mm: simplify mm and CPU checks
>   arm64: mm: kill mm_cpumask usage
>   arm64: tlb: remove redundant barrier from __flush_tlb_pgtable
>   arm64: mm: remove dsb from update_mmu_cache

Series queued for 4.4. Thanks.

-- 
Catalin
