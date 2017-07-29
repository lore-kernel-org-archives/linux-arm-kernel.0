From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 29 Jul 2017 14:31:40 +0800
Subject: [PATCH 0/2] Add ZTE zx-irdec remote control driver
Message-ID: <1501309902-7559-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The series adds dt-bindings and remote control driver for IRDEC block
found on ZTE ZX family SoCs.

Shawn Guo (2):
  dt-bindings: add bindings document for zx-irdec
  rc: add zx-irdec remote control driver

 .../devicetree/bindings/media/zx-irdec.txt         |  14 ++
 drivers/media/rc/Kconfig                           |  11 ++
 drivers/media/rc/Makefile                          |   1 +
 drivers/media/rc/keymaps/Makefile                  |   3 +-
 drivers/media/rc/keymaps/rc-zx-irdec.c             |  79 ++++++++
 drivers/media/rc/zx-irdec.c                        | 198 +++++++++++++++++++++
 include/media/rc-map.h                             |   1 +
 7 files changed, 306 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/zx-irdec.txt
 create mode 100644 drivers/media/rc/keymaps/rc-zx-irdec.c
 create mode 100644 drivers/media/rc/zx-irdec.c

-- 
1.9.1
