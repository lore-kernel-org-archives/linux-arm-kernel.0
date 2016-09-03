From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 3 Sep 2016 11:13:48 +0100
Subject: [GIT PULL] arm64+perf fixes 4.8-rc5
Message-ID: <20160903101345.GA3868@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 and arm/perf fixes below. Thanks.

The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:

  Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 744c6c37cc18705d19e179622f927f5b781fe9cc:

  arm64: kernel: Fix unmasked debug exceptions when restoring mdscr_el1 (2016-09-02 17:19:55 +0100)

----------------------------------------------------------------
- arm64 fix: debug exception unmasking on the CPU resume path
- ARM PMU fixes: memory leak on error path and NULL pointer dereference

----------------------------------------------------------------
James Morse (1):
      arm64: kernel: Fix unmasked debug exceptions when restoring mdscr_el1

Stefan Wahren (2):
      drivers/perf: arm_pmu: Fix leak in error path
      drivers/perf: arm_pmu: Fix NULL pointer dereference during probe

 arch/arm64/mm/proc.S   | 9 +++++++++
 drivers/perf/arm_pmu.c | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
Catalin
