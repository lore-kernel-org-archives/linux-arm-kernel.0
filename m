From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 24 Nov 2018 12:36:40 +0000
Subject: [GIT PULL] arm64 fixes for 4.20-rc4
Message-ID: <20181124123637.matxo4anfxj5q5vm@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 4f9f49646a5733c0c2bd49940673dde89a9c5add:

  arm64: cpufeature: Fix mismerge of CONFIG_ARM64_SSBD block (2018-11-23 18:44:16 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix wrong conflict resolution around CONFIG_ARM64_SSBD

- Fix sparse warning on unsigned long constant

----------------------------------------------------------------
Sergey Matyukevich (1):
      arm64: sysreg: fix sparse warnings

Will Deacon (1):
      arm64: cpufeature: Fix mismerge of CONFIG_ARM64_SSBD block

 arch/arm64/include/asm/sysreg.h | 4 ++--
 arch/arm64/kernel/cpufeature.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Catalin
