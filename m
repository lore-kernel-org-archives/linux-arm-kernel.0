From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 5 Jul 2014 12:30:56 +0100
Subject: [GIT PULL] arm64 fixes for 3.16
Message-ID: <20140705113050.GA28232@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below for 3.16. Thanks.


The following changes since commit 4c834452aad01531db949414f94f817a86348d59:

  Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 974c8e450b9327a03453a4a450a2030b1bd42b5f:

  arm64: fix el2_setup check of CurrentEL (2014-07-04 16:16:52 +0100)

----------------------------------------------------------------
ARM64 fixes:
- Exception level check at boot time (for completeness, not triggering
  any bug before)
- I/D-cache synchronisation logic for huge pages
- Config symbol typo

----------------------------------------------------------------
Marc Zyngier (1):
      arm64: fix el2_setup check of CurrentEL

Steve Capper (2):
      arm64: mm: Fix horrendous config typo
      arm64: mm: Make icache synchronisation logic huge page aware

 arch/arm64/include/asm/pgtable.h | 2 +-
 arch/arm64/include/asm/ptrace.h  | 4 ++++
 arch/arm64/kernel/efi-entry.S    | 3 +--
 arch/arm64/kernel/head.S         | 3 +--
 arch/arm64/mm/flush.c            | 3 ++-
 5 files changed, 9 insertions(+), 6 deletions(-)

-- 
Catalin
