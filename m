From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 18 Mar 2014 19:13:56 +0800
Subject: [PATCH 0/3] [media] atmel-isi: Add DT support for Atmel ISI driver
Message-ID: <1395141238-5948-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add DT support for atmel ISI driver. It can support the
common v4l2 DT interfaces.

Josh Wu (3):
  [media] atmel-isi: add v4l2 async probe support
  [media] atmel-isi: convert the pdata from pointer to structure
  [media] atmel-isi: add primary DT support

 .../devicetree/bindings/media/atmel-isi.txt        |   51 +++++++++++++++++
 drivers/media/platform/soc_camera/atmel-isi.c      |   58 ++++++++++++++++----
 include/media/atmel-isi.h                          |    4 ++
 3 files changed, 101 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/atmel-isi.txt

-- 
1.7.9.5
