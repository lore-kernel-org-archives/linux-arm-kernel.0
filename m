From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Dec 2013 18:33:08 +0000
Subject: [GIT PULL] arm64 ptrace fix for 3.13
Message-ID: <20131219183303.GA12876@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 patch below. Thanks.


The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to cdc27c27843248ae7eb0df5fc261dd004eaa5670:

  arm64: ptrace: avoid using HW_BREAKPOINT_EMPTY for disabled events (2013-12-19 17:41:25 +0000)

----------------------------------------------------------------
- arm64 ptrace fix.

----------------------------------------------------------------
Will Deacon (1):
      arm64: ptrace: avoid using HW_BREAKPOINT_EMPTY for disabled events

 arch/arm64/kernel/ptrace.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

-- 
Catalin
