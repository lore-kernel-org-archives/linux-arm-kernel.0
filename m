From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 25 Jun 2014 17:14:06 +0800
Subject: [PATCH v2 0/2] phy: add hix5hd2-sata-phy driver
Message-ID: <1403687648-29082-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Suggested by Mark
Remove hisilicon,reg-init and init the register in phy-hix5hd2-sata.c
Change property name accordingly.

Jiancheng Xue (2):
  Documentation: Document Hisilicon hix5hd2 sata PHY
  phy: add hix5hd2-sata-phy driver

 .../devicetree/bindings/phy/hix5hd2-sata-phy.txt   |   22 +++
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-hix5hd2-sata.c                     |  190 ++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
 create mode 100644 drivers/phy/phy-hix5hd2-sata.c

-- 
1.7.9.5
