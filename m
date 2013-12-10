From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 10 Dec 2013 14:29:56 -0500
Subject: [PATCH 0/2] mm: memblock: Couple of kbuild fixes after the memblock
 series
Message-ID: <1386703798-26521-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

Thanks to kbuild which almost covers all the architectures builds, couple
of build related issues poped up after the memblock series applied [1]

This series tries to address those build issues.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Grygorii Strashko (2):
  mm/ARM: dma: fix conflicting types for 'arm_dma_zone_size'
  mm/memblock: fix buld of "cris" arch

 arch/arm/include/asm/dma.h |    2 +-
 include/linux/bootmem.h    |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Regards,
Santosh

[1] https://lkml.org/lkml/2013/12/9/715 
-- 
1.7.9.5
