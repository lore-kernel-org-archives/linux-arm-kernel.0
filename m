From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Dec 2014 17:51:10 +0000
Subject: [GIT PULL] arm64 fixes for 3.19
Message-ID: <20141223175102.GA9562@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 5d96e0cba26323c3daeb9f7cdfd4efe70985e2c6:

  arm64: mm: Add pgd_page to support RCU fast_gup (2014-12-23 16:39:17 +0000)

----------------------------------------------------------------
arm64 fixes:
- __cpu_suspend mm switching fix after warm boot
- arch_setup_dma_ops implementation
- pgd_page compilation error fix
- defconfig updates

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Replace set_arch_dma_coherent_ops with arch_setup_dma_ops

Jungseok Lee (1):
      arm64: mm: Add pgd_page to support RCU fast_gup

Lorenzo Pieralisi (1):
      arm64: kernel: fix __cpu_suspend mm switch on warm-boot

Will Deacon (1):
      arm64: defconfig: defconfig update for 3.19

 arch/arm64/configs/defconfig         |  9 +++++----
 arch/arm64/include/asm/dma-mapping.h | 11 ++++++-----
 arch/arm64/include/asm/pgtable.h     |  5 +++--
 arch/arm64/kernel/suspend.c          | 14 +++++++++++++-
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
Catalin
