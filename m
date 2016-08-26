From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Aug 2016 18:41:14 +0100
Subject: [GIT PULL] arm64 fix for 4.8-rc4
Message-ID: <20160826174112.GA27703@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fix below. Thank you.

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to fd363bd417ddb6103564c69cfcbd92d9a7877431:

  arm64: avoid TLB conflict with CONFIG_RANDOMIZE_BASE (2016-08-25 11:11:32 +0100)

----------------------------------------------------------------
ARM64 fix to avoid potential TLB conflict when CONFIG_RANDOMIZE_BASE is
enabled.

----------------------------------------------------------------
Mark Rutland (1):
      arm64: avoid TLB conflict with CONFIG_RANDOMIZE_BASE

 arch/arm64/kernel/head.S | 3 +++
 1 file changed, 3 insertions(+)

-- 
Catalin
