From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Sat, 22 Sep 2018 21:09:51 +0530
Subject: [PATCH 0/5] ARM64 MM Random Cleanups
Message-ID: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This just contains some unrelated cleanup patches on memory.

Anshuman Khandual (5):
  arm64/mm: Use ESR_ELx_FSC macro while decoding fault exception
  arm64/mm: Reorganize arguments for is_el1_permission_fault()
  arm64/mm: Define esr_to_debug_fault_info()
  arm64/numa: Report correct memblock range for the dummy node
  arm64/numa: Unify common error path in numa_init()

 arch/arm64/mm/fault.c | 19 ++++++++++++-------
 arch/arm64/mm/numa.c  | 13 ++++++++-----
 2 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.7.4
