From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Aug 2014 17:49:53 +0800
Subject: [PATCH 0/2] Fixes kernel Oops in imx-drm drivers
Message-ID: <1408441795-24719-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In my testing of bind/unbind (and insmod/rmmod) on imx-drm drivers,
a couple of kernel Oops are seen.  These two patches are trying to
fix them.

Shawn Guo (2):
  imx-drm: imx-ldb: fix kernel Oops in imx_ldb_unbind()
  imx-drm: ipuv3-plane: fix kernel Oops in ipu_dp_put()

 drivers/staging/imx-drm/imx-ldb.c     | 2 ++
 drivers/staging/imx-drm/ipuv3-plane.c | 9 ++-------
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
1.9.1
