From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 05 Apr 2013 17:13:02 -0700
Subject: [GIT PULL] OMAP: PM: cpuidle cleanups for v3.10
Message-ID: <874nfkjz3l.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following changes for OMAP CPUidle for v3.10.

Kevin


The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.10/cleanup/cpuidle

for you to fetch changes up to 2507386b7c01e3b0f6967d12c72467bf3f66c77e:

  ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support (2013-04-05 13:37:33 -0700)

----------------------------------------------------------------
OMAP3/4 CPUidle cleanups for v3.10

----------------------------------------------------------------
Daniel Lezcano (1):
      ARM: omap3: cpuidle: enable time keeping

Santosh Shilimkar (5):
      ARM: OMAP4: CPUidle: Avoid double idle driver registration
      ARM: OMAP: CPUidle: Unregister drivere on device registration failure
      ARM: OMAP4: CPUidle: Make C-state description field more precise
      ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()
      ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support

 arch/arm/mach-omap2/common.h              |  5 ----
 arch/arm/mach-omap2/cpuidle34xx.c         | 11 +++++--
 arch/arm/mach-omap2/cpuidle44xx.c         | 48 +++++++++++++++++--------------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 14 ---------
 4 files changed, 35 insertions(+), 43 deletions(-)
