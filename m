From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Jan 2014 18:55:39 +0000
Subject: [GIT PULL] arm64 revert for 3.13
Message-ID: <20140116185533.GA16442@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

If there's still time for 3.13, could you please pull the one-line
revert below? We noticed that it breaks ioremap (and earlyprintk) with
64K page configuration. Thanks.

The following changes since commit cdc27c27843248ae7eb0df5fc261dd004eaa5670:

  arm64: ptrace: avoid using HW_BREAKPOINT_EMPTY for disabled events (2013-12-19 17:41:25 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 4ce00dfcf19c473f3dbf23d5b1372639f0c334f6:

  Revert "arm64: Fix memory shareability attribute for ioremap_wc/cache" (2014-01-16 18:32:25 +0000)

----------------------------------------------------------------
Revert "arm64: Fix memory shareability attribute for ioremap_wc/cache"

----------------------------------------------------------------
Catalin Marinas (1):
      Revert "arm64: Fix memory shareability attribute for ioremap_wc/cache"

 arch/arm64/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
