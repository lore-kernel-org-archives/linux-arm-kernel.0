From: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 5 Jul 2014 10:55:24 +0100
Subject: [GIT PULL] imx-drm update for component changes
Message-ID: <20140705095524.GA28759@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

Please incorporate the imx-drm update for component changes, which can
be found at:

  git://ftp.arm.linux.org.uk/~rmk/linux-arm.git component-for-staging

with SHA1 9e5e2ffda320bacb761e4812e3ef7a7decd592a9.

This updates imx-drm for the recently merged updates to the component
helper, and as such is based upon the previously pulled updates
(including the recent fix) into the the driver tree.

This will update the following files:

 drivers/base/component.c               | 192 +++++++++++++++++++++++++++------
 drivers/staging/imx-drm/imx-drm-core.c |  57 +---------
 include/linux/component.h              |   7 ++
 3 files changed, 168 insertions(+), 88 deletions(-)

through these changes:

Russell King (5):
      component: fix missed cleanup in case of devres failure
      component: ignore multiple additions of the same component
      component: add support for component match array
      component: fix bug with legacy API
      imx-drm: update to use component match support

Many thanks.
