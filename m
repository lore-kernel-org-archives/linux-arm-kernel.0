From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 8 Apr 2013 16:46:23 +0300
Subject: [GIT PULL] remoteproc fixes for 3.9
Message-ID: <CAK=WgbY-M-ZrhAO5rhZazNNK4X706PCYPOS6Ag5pXSsNeM2OGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-3.9-fixes

for you to fetch changes up to c7426bce5933d16b492a34e42ae77e26fceddff6:

  remoteproc: fix FW_CONFIG typo (2013-04-07 15:11:27 +0300)

----------------------------------------------------------------
4 small remoteproc fixes:
- Suman fixed an issue that crawled in with the move to the new
  idr_alloc interface in 3.9
- Dmitry fixed an STE specific memory leak
- Sjur fixed an error path in the core
- Rob fixed a Kconfig typo

----------------------------------------------------------------
Dmitry Tarnyagin (1):
      remoteproc/ste: fix memory leak on shutdown

Robert Tivy (1):
      remoteproc: fix FW_CONFIG typo

Sjur Br?ndeland (1):
      remoteproc: fix error path of handle_vdev

Suman Anna (1):
      remoteproc: fix the error check for idr_alloc

 drivers/remoteproc/Kconfig           | 2 +-
 drivers/remoteproc/remoteproc_core.c | 6 ++++--
 drivers/remoteproc/ste_modem_rproc.c | 7 ++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)
