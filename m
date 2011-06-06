From: khilman@ti.com (Kevin Hilman)
Date: Mon, 06 Jun 2011 16:29:43 -0700
Subject: [GIT PULL] OMAP PM fixes for v3.0-rc
Message-ID: <87oc2atu6w.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following fixes for v3.0-rc.  Looks like I just missed
your pull request, so you can add this to the next one.

Note that I split the section mismatch patch from Russell into two.  One
to go through you for OMAP core and the other (GPIO) to go through that
driver tree.

Kevin


The following changes since commit 59c5f46fbe01a00eedf54a23789634438bb80603:

  Linux 3.0-rc2 (2011-06-06 18:06:33 +0900)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.0/pm-fixes

Kevin Hilman (1):
      OMAP: PM: omap_device: fix device power domain callbacks

Russell King (1):
      OMAP: PM debug: fix section mismatch warnings

 arch/arm/mach-omap2/pm-debug.c   |    4 ++--
 arch/arm/plat-omap/omap_device.c |   19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)
