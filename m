From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 May 2018 11:48:14 +0100
Subject: [PATCH v2] arm64: Remove duplicate include
In-Reply-To: <1523630675-30687-1-git-send-email-vincenzo.frascino@arm.com>
References: <1523630675-30687-1-git-send-email-vincenzo.frascino@arm.com>
Message-ID: <20180516104814.i7sgeodnmgygjceg@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2018 at 03:44:35PM +0100, Vincenzo Frascino wrote:
> "make includecheck" detected few duplicated includes in arch/arm64.
> 
> This patch removes the double inclusions.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h     | 1 -
>  arch/arm64/kernel/armv8_deprecated.c | 3 +--
>  arch/arm64/kernel/fpsimd.c           | 1 -
>  arch/arm64/kernel/ptrace.c           | 2 --
>  4 files changed, 1 insertion(+), 6 deletions(-)

Queued for 4.18. Thanks.

-- 
Catalin
