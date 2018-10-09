From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Oct 2018 12:57:04 +0100
Subject: [PATCH] arm64: mm: Drop the unused cpu parameter
In-Reply-To: <1538815744-27408-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1538815744-27408-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20181009115704.GC6248@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 06, 2018 at 04:49:04PM +0800, Shaokun Zhang wrote:
> Cpu parameter is never used in flush_context, remove it.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  arch/arm64/mm/context.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Curious, but does this actually result in better code generation, or does
GCC already figure out that the parameter is unused?

Will
