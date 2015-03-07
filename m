From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 7 Mar 2015 10:57:47 +0000
Subject: [GIT PULL] arm64 fixes for 4.0
Message-ID: <20150307105747.GB3861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 168e47f2a6581fdbc5bb1845aeca1e50e2bc5c4b:

  kernel/module.c: Update debug alignment after symtable generation (2015-03-06 12:04:22 +0000)

----------------------------------------------------------------
arm64 and generic kernel/module.c (acked by Rusty) fixes for
CONFIG_DEBUG_SET_MODULE_RONX.

----------------------------------------------------------------
Laura Abbott (2):
      arm64: Don't use is_module_addr in setting page attributes
      kernel/module.c: Update debug alignment after symtable generation

 arch/arm64/mm/pageattr.c | 5 ++++-
 kernel/module.c          | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
Catalin
