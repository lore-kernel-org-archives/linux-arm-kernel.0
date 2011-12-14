From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 14 Dec 2011 13:48:28 +0200
Subject: [PATCH 0/7] remoteproc/rpmsg: a few trivial fixes
Message-ID: <1323863315-8159-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two fixes from Mark (required for controlling non-IOMMU and non-Virtio
remote processors via remoteproc), two fixes which were reported by
Stephen Boyd, and three other trivial cleanups.

Mark Grosen (2):
  remoteproc: do not require an iommu
  remoteproc: avoid registering a virtio device if not supported

Ohad Ben-Cohen (5):
  remoteproc: remove unused resource type
  remoteproc/omap: utilize module_platform_driver
  remoteproc: look for truncated firmware images
  remoteproc: add Kconfig menu
  rpmsg: add Kconfig menu

 drivers/remoteproc/Kconfig           |    4 +++
 drivers/remoteproc/omap_remoteproc.c |   13 +----------
 drivers/remoteproc/remoteproc_core.c |   41 +++++++++++++++++++++++++++------
 drivers/rpmsg/Kconfig                |    4 +++
 include/linux/remoteproc.h           |    1 -
 5 files changed, 42 insertions(+), 21 deletions(-)

-- 
1.7.5.4
