From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu,  4 Jun 2015 18:58:35 -0700
Subject: [PATCH 0/3] ARM: Allow SPARSEMEM on multiplatform build
Message-ID: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is based on the changeset submitted by Kevin Cernekee last September:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286835.html

The changes I have made are:
- update commit messages per review comments from Arnd and Russell
- change to allow FLATMEM or SPARSEMEM on all multiplatform builds, not just
  multi-v7

Gregory Fong (1):
  ARM: Allow either FLATMEM or SPARSEMEM on the multiplatform build

Kevin Cernekee (2):
  ARM: Add default SPARSEMEM settings
  ARM: Remove redundant ARCH_SPARSEMEM_DEFAULT setting

 arch/arm/Kconfig                 | 8 +++++---
 arch/arm/include/asm/sparsemem.h | 7 ++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
1.9.1
