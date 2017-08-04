From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Aug 2017 13:08:58 +0100
Subject: [PATCH 0/5] Simplify kernel-mode NEON
In-Reply-To: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
References: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170804120858.ff3772f3zzik37pp@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 05:23:18PM +0100, Dave P Martin wrote:
> Ard Biesheuvel (1):
>   arm64: neon: replace generic definition of may_use_simd()
> 
> Dave Martin (4):
>   arm64: neon: Add missing header guard in <asm/neon.h>
>   arm64: fpsimd: Consistently use __this_cpu_ ops where appropriate
>   arm64: neon: Allow EFI runtime services to use FPSIMD in irq context
>   arm64: neon: Remove support for nested or hardirq kernel-mode NEON

Queued for 4.14. Thanks.

-- 
Catalin
