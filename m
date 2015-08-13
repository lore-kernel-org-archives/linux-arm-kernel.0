From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Aug 2015 01:20:22 -0700
Subject: [GIT PULL] omap gpmc null pointer fix against v4.2-rc6
Message-ID: <20150813082022.GL10928@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cd4556733b30cc363adc7b1cea3bffa7e2dd0c7c:

  ARM: dts: dra7: Fix broken pbias device creation (2015-08-05 03:04:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc6

for you to fetch changes up to e984a1791ac6a7c944911207e8a9c344763f0003:

  memory: omap-gpmc: Don't try to save uninitialized GPMC context (2015-08-12 01:43:49 -0700)

----------------------------------------------------------------
Fix a NULL pointer exception for omap GPMC bus code if probe fails.

----------------------------------------------------------------
Tomeu Vizoso (1):
      memory: omap-gpmc: Don't try to save uninitialized GPMC context

 drivers/memory/omap-gpmc.c | 6 ++++++
 1 file changed, 6 insertions(+)
