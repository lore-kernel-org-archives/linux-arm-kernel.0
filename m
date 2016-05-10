From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 10 May 2016 09:25:21 -0500
Subject: [GIT PULL] SoCFPGA update for v4.7
Message-ID: <1462890321-13569-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof:

Please pull in this update for v4.7. I aplogize for the lateness of this PR,
but this patch is dependent on a fix that went in on v4.6-rc7.

That fix is "2882f7637075 ARM: SoCFPGA: simplify secondary trampoline".

Thanks,
Dinh

The following changes since commit 44549e8f5eea4e0a41b487b63e616cb089922b99:

  Linux 4.6-rc7 (2016-05-08 14:38:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_updates_for_v4.7

for you to fetch changes up to 2882f7637075f876342a6378074d2911cac2fee2:

  ARM: SoCFPGA: simplify secondary trampoline (2016-05-09 13:45:20 -0500)

----------------------------------------------------------------
SoCFPGA updates for v4.7
- Simplify secondary trampoline SMP code

----------------------------------------------------------------
Sascha Hauer (1):
      ARM: SoCFPGA: simplify secondary trampoline

 arch/arm/mach-socfpga/core.h    |  4 ++--
 arch/arm/mach-socfpga/headsmp.S | 27 +++++++---------------
 arch/arm/mach-socfpga/platsmp.c | 51 +++++++++++++++++++----------------------
 arch/arm/mach-socfpga/socfpga.c |  9 --------
 4 files changed, 33 insertions(+), 58 deletions(-)
