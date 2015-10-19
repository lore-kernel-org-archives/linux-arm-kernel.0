From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Oct 2015 18:30:41 +0100
Subject: [UPDATED] [PATCHv4 00/12] arm64: 16K translation granule support
In-Reply-To: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
References: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151019173040.GF11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:19:26PM +0100, Suzuki K. Poulose wrote:
> Ard Biesheuvel (1):
>   arm64: Add page size to the kernel image header
> 
> Mark Rutland (1):
>   arm64: Simplify NR_FIX_BTMAPS calculation
> 
> Suzuki K. Poulose (10):
>   arm64: Move swapper pagetable definitions
>   arm64: Handle section maps for swapper/idmap
>   arm64: Introduce helpers for page table levels
>   arm64: Calculate size for idmap_pg_dir at compile time
>   arm64: Handle 4 level page table for swapper
>   arm64: Clean config usages for page size
>   arm64: Kconfig: Fix help text about AArch32 support with 64K pages
>   arm64: Check for selected granule support
>   arm64: Add 16K page size support
>   arm64: 36 bit VA

Patches applied. I'm not fully convinced about the 36-bit VA yet, it
increases the validation space and I think with little benefit (to be
seen on real hardware). I may make it depend on EXPERT.

Thanks.

-- 
Catalin
