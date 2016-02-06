From: labbott@fedoraproject.org (Laura Abbott)
Date: Fri,  5 Feb 2016 16:24:45 -0800
Subject: [PATCHv4 0/3] ARCH_SUPPORTS_DEBUG_PAGEALLOC for arm64
Message-ID: <1454718288-31374-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is hopefully the last update to add proper ARCH_SUPPORTS_DEBUG_PAGEALLOC
support for arm64.

Changes since v3:
- More acks
- Pulled out block check into a separate function
- Style fixups
- Comment tweaking

Laura Abbott (3):
  arm64: Drop alloc function from create_mapping
  arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
  arm64: ptdump: Indicate whether memory should be faulting

 arch/arm64/Kconfig       |  3 +++
 arch/arm64/mm/dump.c     |  5 +++++
 arch/arm64/mm/mmu.c      | 48 +++++++++++++++++++++++++++++++++++++-----------
 arch/arm64/mm/pageattr.c | 46 ++++++++++++++++++++++++++++++++++++----------
 4 files changed, 81 insertions(+), 21 deletions(-)

-- 
2.5.0
