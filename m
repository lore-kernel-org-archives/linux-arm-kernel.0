From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Apr 2018 18:59:38 +0100
Subject: [GIT PULL] arm64 fixes for 4.17-rc2
Message-ID: <20180420175935.obbvf5ype6n2odoq@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to b2d71b3cda19831ec67f49d7c6ba0214d9367b29:

  arm64: signal: don't force known signals to SIGKILL (2018-04-18 15:13:27 +0100)

----------------------------------------------------------------
arm64 fixes:

- KASan: avoid pfn_to_nid() before the page array is initialised

- Fix typo causing the "upgrade" of known signals to SIGKILL

----------------------------------------------------------------
Mark Rutland (2):
      arm64: kasan: avoid pfn_to_nid() before page array is initialized
      arm64: signal: don't force known signals to SIGKILL

 arch/arm64/kernel/traps.c  | 2 +-
 arch/arm64/mm/kasan_init.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Catalin
