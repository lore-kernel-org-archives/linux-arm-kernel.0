From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 25 Mar 2014 18:41:25 +0800
Subject: [PATCH v2 0/3] [media] atmel-isi: Add DT support for Atmel ISI driver
Message-ID: <1395744087-5753-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add DT support for atmel ISI driver. It can support the
common v4l2 DT interfaces.

v1 --> v2:
  modified the device tree binding document to remove the a optional property.

Josh Wu (3):
  [media] atmel-isi: add v4l2 async probe support
  [media] atmel-isi: convert the pdata from pointer to structure
  [media] atmel-isi: add primary DT support

 .../devicetree/bindings/media/atmel-isi.txt        |   50 +++++++++++++++++
 drivers/media/platform/soc_camera/atmel-isi.c      |   56 +++++++++++++++-----
 include/media/atmel-isi.h                          |    4 ++
 3 files changed, 98 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/atmel-isi.txt

-- 
1.7.9.5
