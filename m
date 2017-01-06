From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Jan 2017 18:05:22 +0000
Subject: [GIT PULL] arm64 fixes for 4.10-rc3
Message-ID: <20170106180519.GA4700@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 9d84fb27fa135c99c9fe3de33628774a336a70a8:

  arm64: restore get_current() optimisation (2017-01-04 16:26:18 +0000)

----------------------------------------------------------------
- Re-introduce the arm64 get_current() optimisation
- KERN_CONT fallout fix in show_pte()

----------------------------------------------------------------
Mark Rutland (2):
      arm64: mm: fix show_pte KERN_CONT fallout
      arm64: restore get_current() optimisation

 arch/arm64/include/asm/current.h | 10 +++++++++-
 arch/arm64/mm/fault.c            |  8 ++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
Catalin
