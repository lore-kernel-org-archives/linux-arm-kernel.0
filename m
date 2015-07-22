From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Jul 2015 14:24:16 +0100
Subject: [GIT PULL] arm64 fixes for 4.2
Message-ID: <20150722132415.GA17651@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 patches below. Thanks.

The following changes since commit 52721d9d3334c1cb1f76219a161084094ec634dc:

  Linux 4.2-rc3 (2015-07-19 14:45:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 3bc38fc110c642c0a455a5214465bb4d62805a75:

  ARM64/irq: Use access helper irq_data_get_affinity_mask() (2015-07-22 10:57:09 +0100)

----------------------------------------------------------------
- arm64 build fix following the move of the thread_struct to the end of
  task_struct and the asm offsets becoming too large for the AArch64 ISA

- preparatory patch for moving irq_data struct members (applied now to
  reduce dependency for the next merging window)

----------------------------------------------------------------
Jiang Liu (1):
      ARM64/irq: Use access helper irq_data_get_affinity_mask()

Will Deacon (1):
      arm64: switch_to: calculate cpu context pointer using separate register

 arch/arm64/kernel/entry.S | 5 +++--
 arch/arm64/kernel/irq.c   | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
Catalin
