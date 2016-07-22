From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Fri, 22 Jul 2016 16:48:50 +0800
Subject: [RFC PATCH v1 0/2] Add Hisilicon Djtag driver
Message-ID: <1469177332-72156-1-git-send-email-tanxiaojun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Tan Xiaojun (2):
  Documentation: arm64: Add Hisilicon HiP05/06/07 Sysctrl and Djtag dts
    bindings
  drivers: soc: Add support for Hisilicon Djtag driver

 .../bindings/arm/hisilicon/hisilicon.txt           |   98 +++++
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/hisilicon/Kconfig                      |   12 +
 drivers/soc/hisilicon/Makefile                     |    1 +
 drivers/soc/hisilicon/djtag.c                      |  373 ++++++++++++++++++++
 include/linux/soc/hisilicon/djtag.h                |   18 +
 7 files changed, 504 insertions(+)
 create mode 100644 drivers/soc/hisilicon/Kconfig
 create mode 100644 drivers/soc/hisilicon/Makefile
 create mode 100644 drivers/soc/hisilicon/djtag.c
 create mode 100644 include/linux/soc/hisilicon/djtag.h

-- 
1.7.9.5
