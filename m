From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Sep 2015 05:37:06 +0000
Subject: [PATCH 0/3] remoteproc: add CSRatlas7 remoteproc driver
Message-ID: <1442295429-19137-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

The first two patches make remoteproc support non-slave remote processors.
the last one adds CSRatlas7 support.

Wei Chen (3):
  drivers:remoteproc:support predefined vq notifyid
  drivers:remoteproc:support always on remote processor
  remoteproc: add CSRatlas7 remoteproc driver

 .../bindings/remoteproc/sirf,remoteproc.txt        |  33 ++
 drivers/remoteproc/Kconfig                         |  13 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/remoteproc_core.c               |  21 +-
 drivers/remoteproc/remoteproc_virtio.c             |   8 +
 drivers/remoteproc/sirf_remoteproc.c               | 467 +++++++++++++++++++++
 include/linux/remoteproc.h                         |   4 +-
 7 files changed, 541 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/sirf,remoteproc.txt
 create mode 100644 drivers/remoteproc/sirf_remoteproc.c

-- 
1.9.1
