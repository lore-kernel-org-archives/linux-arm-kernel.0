From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Fri, 6 Jun 2014 11:00:57 -0500
Subject: dma_get_required_mask for ARM64
Message-ID: <5391E5B9.3010708@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin/Will,

In the arch/arm64/include/asm/dma-mapping.h defines the macro 
"ARCH_HAS_DMA_GET_REQUIRED_MASK".  However, I can't seem to find where 
the function "dma_get_required_mask" defined for ARM64. I got a 
compilation error when building one of the driver:

ERROR: "dma_get_required_mask" [drivers/scsi/mpt2sas/mpt2sas.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Is this function defined anywhere for ARM64?

Thank you,

Suravee
