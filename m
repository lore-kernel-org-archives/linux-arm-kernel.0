From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 28 Jan 2017 10:27:05 +0000
Subject: [GIT PULL] arm64 fixes for 4.10-rc6
Message-ID: <20170128102702.GA15956@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fix for 4.10 below. Thanks.

The following changes since commit 7a308bb3016f57e5be11a677d15b821536419d36:

  Linux 4.10-rc5 (2017-01-22 12:54:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 606f42265d384b9149bfb953c5dfc6d4710fef4c:

  arm64: skip register_cpufreq_notifier on ACPI-based systems (2017-01-27 11:30:36 +0000)

----------------------------------------------------------------
- Fix kernel panic on ACPI-based systems where CPU capacity description
  is not currently handled

----------------------------------------------------------------
Prashanth Prakash (1):
      arm64: skip register_cpufreq_notifier on ACPI-based systems

 arch/arm64/kernel/topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
Catalin
