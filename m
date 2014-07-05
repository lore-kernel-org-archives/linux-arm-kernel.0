From: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 5 Jul 2014 10:51:02 +0100
Subject: [GIT PULL] component fix
Message-ID: <20140705095102.GA26803@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

Please incorporate a fix for the component helper, which can be found at:

  git://ftp.arm.linux.org.uk/~rmk/linux-arm.git component-for-driver

with SHA1 b509cc802239a8b5ba7d1d2cc5adfb9d984b7ed8.

This fixes a bug reported by Sachin Kamat found with Exynos DRM.

This will update the following files:

 drivers/base/component.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

through these changes:

Russell King (1):
      component: fix bug with legacy API

Many thanks.
