From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 20 Apr 2015 22:15:54 +0300
Subject: [GIT PULL] remoteproc for 4.1
Message-ID: <CAK=Wgba5=MsiH+OiN=XyHbbaws_ZRte8KwOGANchA2PpxBBEqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-4.1-next

for you to fetch changes up to 315491e5d6ee66838a18a8ca0c14e6ffb376e48c:

  remoteproc: add IOMMU hardware capability flag (2015-03-12 10:43:26 +0200)

----------------------------------------------------------------
Suman Anna is adding remoteproc support for processors not behind IOMMUs.

----------------------------------------------------------------
Suman Anna (1):
      remoteproc: add IOMMU hardware capability flag

 drivers/remoteproc/da8xx_remoteproc.c |  1 +
 drivers/remoteproc/omap_remoteproc.c  |  2 ++
 drivers/remoteproc/remoteproc_core.c  | 15 ++-------------
 drivers/remoteproc/ste_modem_rproc.c  |  1 +
 include/linux/remoteproc.h            |  2 ++
 5 files changed, 8 insertions(+), 13 deletions(-)
