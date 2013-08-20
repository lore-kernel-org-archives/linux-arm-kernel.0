From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Aug 2013 18:22:51 +0100
Subject: [GIT PULL] arm64 perf fixes for 3.11
Message-ID: <20130820172245.GA23603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Late pull request for arm64 perf fixes (similar to the recent arm perf
patches). Thanks.


The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

  Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git tags/arm64-stable

for you to fetch changes up to ee7538a008a45050c8f706d38b600f55953169f9:

  arm64: perf: fix event validation for software group leaders (2013-08-20 12:05:57 +0100)

----------------------------------------------------------------
Perf backend fixes for arm64 where the user can cause kernel panic
(discovered with Vince's fuzzing tool).

----------------------------------------------------------------
Will Deacon (2):
      arm64: perf: fix array out of bounds access in armpmu_map_hw_event()
      arm64: perf: fix event validation for software group leaders

 arch/arm64/kernel/perf_event.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
Catalin
