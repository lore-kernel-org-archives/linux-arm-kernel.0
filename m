From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 10 Oct 2013 10:30:15 +0800
Subject: [PATCH 0/3] s390/arm/arm64: include: asm: atomic.h: use 'unsigned
 int' and 'atomic_t' instead of 'unsigned long' for atomic_*_mask()
Message-ID: <52561137.3070608@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For atomic_*_mask(), the 'atomic_t' is 32-bit, so for the 'mask', also
need mach it.


Patch 1/3: s390: include: asm: atomic.h: use 'unsigned int' instead of
'unsigned long' for atomic_*_mask().

Patch 2/3: arm: include: asm: atomic.h: use 'unsigned int' and 'atomic'
instead of 'unsigned long' for atomic_clear_mask().

Patch 3/3: arm64: include: asm: atomic.h: use 'unsigned int' and
'atomic_t' instead of 'unsigned long' for atomic_clear_mask().


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/include/asm/atomic.h   |   13 +++++++------
 arch/arm64/include/asm/atomic.h |   13 +++++++------
 arch/s390/include/asm/atomic.h  |    4 ++--
 3 files changed, 16 insertions(+), 14 deletions(-)
