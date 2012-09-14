From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Sep 2012 19:34:10 -0700
Subject: [GIT PULL 2/7] omap device changes for v3.7 merge window
In-Reply-To: <pull-1347590052-683636>
Message-ID: <mailman.8.1347590078.1458.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/devel-omap-device-for-v3.7

for you to fetch changes up to 47d85ec2a23552fd3d8b56778a23a5a843c5b9b1:

  Merge tag 'for_3.7-omap_device' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into devel-omap-device (2012-09-12 21:17:56 -0700)

----------------------------------------------------------------

Kevin Hilman <khilman@ti.com>:

Updates for omap_device layer for v3.7.

Allows omap_device layer to keep track of driver bound status in order
to make more intelligent decisions about idling unused devices.

----------------------------------------------------------------
Kevin Hilman (3):
      ARM: OMAP: omap_device: keep track of driver bound status
      ARM: OMAP: omap_device: don't attempt late suspend if no driver bound
      ARM: OMAP: omap_device: idle devices with no driver bound

Tony Lindgren (1):
      Merge tag 'for_3.7-omap_device' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-omap-device

 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/omap_device.c              |   56 ++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)
