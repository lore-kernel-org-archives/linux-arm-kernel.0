From: bhumirks@gmail.com (Bhumika Goyal)
Date: Fri, 18 Aug 2017 21:36:56 +0530
Subject: [PATCH 0/2] drivers: make i2c_algorithm const
Message-ID: <1503072418-6887-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const.

Bhumika Goyal (2):
  i2c: busses: make i2c_algorithm const
  [media] usb: make i2c_algorithm const

 drivers/i2c/busses/i2c-pnx.c                 | 2 +-
 drivers/i2c/busses/i2c-puv3.c                | 2 +-
 drivers/media/usb/au0828/au0828-i2c.c        | 2 +-
 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1
