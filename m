From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 25 Jul 2014 18:13:37 +0800
Subject: [PATCH v3 0/3] media: atmel-isi: Add DT support for Atmel ISI driver
Message-ID: <1406283219-32015-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add DT support for atmel ISI driver. It can support the
common v4l2 DT interfaces.

v2 -> v3:
  support bus-width property for atmel-isi endpoint.

v1 -> v2:
  modified the device tree binding document to remove an optonal property.

Josh Wu (3):
  atmel-isi: add v4l2 async probe support
  atmel-isi: convert the pdata from pointer to structure
  atmel-isi: add primary DT support

 .../devicetree/bindings/media/atmel-isi.txt        | 51 +++++++++++++
 drivers/media/platform/soc_camera/atmel-isi.c      | 89 +++++++++++++++++++---
 include/media/atmel-isi.h                          |  4 +
 3 files changed, 132 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/atmel-isi.txt

-- 
1.9.1
