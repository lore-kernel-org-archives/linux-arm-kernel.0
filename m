From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 26 Oct 2012 07:48:17 +0000
Subject: Build broken on linus/master?
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBE9565@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Compiling the current linus/master (2ab3f29) using omap2plus_defconfig
throws up the following error

$make -j7 uImage
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/dma-mapping.h:76:0,
                 from arch/arm/kernel/asm-offsets.c:15:
/datalocal/kernel/arch/arm/include/asm/dma-mapping.h: In function 'dma_mapping_error':
/datalocal/kernel/arch/arm/include/asm/dma-mapping.h:94:2: error: implicit declaration of function 'debug_dma_mapping_error'
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

Regards,
Vaibhav B.
