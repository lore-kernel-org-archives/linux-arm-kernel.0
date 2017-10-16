From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Oct 2017 16:28:37 +0100
Subject: [GIT PULL] arch_timer updates for v4.15
Message-ID: <20171016152839.14964-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Please could you pull these arch timer updates for v4.15?

The first patch is a fix from Ard that fixes probling the MMIO timers on some
platforms. The other patch is a minor cleanup that prevents a warning when
building tags.

Thanks,
Mark.

The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git tags/arch-timer-4.15

for you to fetch changes up to cb3a23a029f6af0c73498b6a9773d6ec19541bf1:

  clocksource: arm_arch_timer: fix DEFINE_PER_CPU expansion (2017-10-16 15:37:16 +0100)

----------------------------------------------------------------
arch_timer updates for v4.15

- enable the MMIO CNTFRQ before reading it
- avoid a warning when building tags

----------------------------------------------------------------
Ard Biesheuvel (1):
      clocksource: arm_arch_timer: validate CNTFRQ after enabling frame

Mark Rutland (1):
      clocksource: arm_arch_timer: fix DEFINE_PER_CPU expansion

 drivers/clocksource/arm_arch_timer.c | 41 +++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 19 deletions(-)
