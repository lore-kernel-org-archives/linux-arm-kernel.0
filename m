From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 7 Jul 2014 20:15:37 +0100
Subject: [PATCH v3 0/2] efi/arm64: FP/SIMD preserve/restore during UEFI
 Runtime Services
In-Reply-To: <1404495713-10338-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1404495713-10338-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140707191537.GC2914@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jul, at 07:41:51PM, Ard Biesheuvel wrote:
> Two patches to add FP/SIMD preserve/restore to UEFI Runtime Services:
> - patch #1 moves runtime services wrappers to generic code so we can reuse them
>   for arm64
> - patch #2 enables the wrappers for arm64 and inserts calls to kernel_neon_begin
>   and kernel_neon_end
> 
> @Matt: please queue up for 3.17

Thanks Ard, applied.

FYI that "please queue up for 3.17" message is super helpful when I'm
trying to figure out what branch to apply this to.

-- 
Matt Fleming, Intel Open Source Technology Center
