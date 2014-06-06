From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Jun 2014 22:27:30 +0100
Subject: dma_get_required_mask for ARM64
In-Reply-To: <5391E5B9.3010708@amd.com>
References: <5391E5B9.3010708@amd.com>
Message-ID: <740EB1CD-93D4-4C1F-9718-7F8D42731FF1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 Jun 2014, at 17:00, Suravee Suthikulanit <suravee.suthikulpanit@amd.com> wrote:
> In the arch/arm64/include/asm/dma-mapping.h defines the macro 
> "ARCH_HAS_DMA_GET_REQUIRED_MASK".  However, I can't seem to find where 
> the function "dma_get_required_mask" defined for ARM64. I got a 
> compilation error when building one of the driver:
> 
> ERROR: "dma_get_required_mask" [drivers/scsi/mpt2sas/mpt2sas.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> Is this function defined anywhere for ARM64?

No, and I don?t remember to have had a reason for this. Please send a
patch removing it.

Thanks,

Catalin
