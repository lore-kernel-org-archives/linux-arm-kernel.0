From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 27 May 2014 20:44:25 +0800
Subject: [PATCH v2 0/2] add hix5hd2 mac driver
Message-ID: <1401194667-14445-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Update binding accoring to Sergei comments
Update descriptor as Arnd's suggestion

Zhangfei Gao (2):
  Documentation: add Device tree bindings for Hisilicon hix5hd2
    ethernet
  net: hisilicon: add hix5hd2 mac driver

 .../bindings/net/hisilicon-hix5hd2-gmac.txt        |   36 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/hisilicon/Kconfig             |   27 +
 drivers/net/ethernet/hisilicon/Makefile            |    5 +
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      | 1062 ++++++++++++++++++++
 6 files changed, 1132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hix5hd2-gmac.txt
 create mode 100644 drivers/net/ethernet/hisilicon/Kconfig
 create mode 100644 drivers/net/ethernet/hisilicon/Makefile
 create mode 100644 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c

-- 
1.7.9.5
