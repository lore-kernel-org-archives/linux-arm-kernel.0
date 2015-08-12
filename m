From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Aug 2015 19:08:46 +0100
Subject: [GIT PULL] arm64 fixes for 4.2
Message-ID: <20150812180844.GA32301@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit f7644cbfcdf03528f0f450f3940c4985b2291f49:

  Linux 4.2-rc6 (2015-08-09 15:54:30 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 878854a374620a3f5e8c0a3c418e82a429bc2cff:

  arm64: VDSO: fix coarse clock monotonicity regression (2015-08-10 15:37:45 +0100)

----------------------------------------------------------------
Fix coarse clock monotonicity (VDSO timestamp off by one jiffy compared
to the syscall one).

----------------------------------------------------------------
Nathan Lynch (1):
      arm64: VDSO: fix coarse clock monotonicity regression

 arch/arm64/kernel/vdso.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
Catalin
