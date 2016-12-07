From: scott.branden@broadcom.com (Scott Branden)
Date: Wed,  7 Dec 2016 11:39:59 -0800
Subject: [PATCH 0/1] arm64: mm: add config options for page table configuration
Message-ID: <1481139600-24455-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces config option CONFIG_MAX_PHYSMEM_BITS and
CONFIG_SECTIONS_SIZE_BITS to allow for memory savings for devices with
small memory areas in sparse memory configurations.

Scott Branden (1):
  arm64: mm: add config options for page table configuration

 arch/arm64/Kconfig                 | 21 +++++++++++++++++++++
 arch/arm64/include/asm/sparsemem.h |  4 ++--
 2 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.5.0
