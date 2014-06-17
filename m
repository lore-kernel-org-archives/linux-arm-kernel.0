From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 17 Jun 2014 15:57:59 +0800
Subject: [PATCH 0/2] phy: add hix5hd2-sata-phy driver
Message-ID: <1402991881-27676-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jiancheng Xue (2):
  Documentation: Document Hisilicon hix5hd2 sata PHY
  phy: add hix5hd2-sata-phy driver

 .../devicetree/bindings/phy/hix5hd2-sata-phy.txt   |   26 +++
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-hix5hd2-sata.c                     |  192 ++++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
 create mode 100644 drivers/phy/phy-hix5hd2-sata.c

-- 
1.7.9.5
