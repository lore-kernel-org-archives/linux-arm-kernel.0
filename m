From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sun, 10 Apr 2011 22:04:03 +0800
Subject: about uclinux for armnommu dma allocate issue
Message-ID: <BANLkTikkzWZcfeic8qUeLKLr5+ef14eA4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

I am programming ohci driver for my arm7 based on 2.6.38.

td_alloc -> dma_pool_alloc -> dma_alloc_coherent().

In previous uclinux version, there is the consistent.c located in
arch/armnommu/mm to implement
this dma_alloc_coherent, but now this latest version, I did not see
this 'dma_alloc_coherent' function
for armnommu, so I can use this function directly like this arm mmu?

In addtion, the 'kmalloc' is the same to previous uclinux armnommu
version? I can use it directly?

Wan.

thanks!
-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
