From: bs14@csr.com (Barry Song)
Date: Thu, 7 Jul 2011 19:54:26 -0700
Subject: [PATCH 0/3] *** add lost UL suffix to VMALLOC_END ***
Message-ID: <1310093669-4681-1-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After grepping, several platforms lost the UL suffix for VMALLOC_END.

Barry Song (3):
  ARM: CNS3XXX: add UL suffix to VMALLOC_END to ensure it is properly
    typed
  ARM: LPC32XXX: add UL suffix to VMALLOC_END to ensure it is properly
    typed
  ARM: NUC93X: add UL suffix to VMALLOC_END to ensure it is properly
    typed

 arch/arm/mach-cns3xxx/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-lpc32xx/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-nuc93x/include/mach/vmalloc.h  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
