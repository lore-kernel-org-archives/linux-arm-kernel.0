From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 10 Oct 2013 22:36:51 +0800
Subject: [PATCH 0/2] add dw_mmc-k3.c
Message-ID: <1381415813-9395-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support mmc for k3v2, base on dw_mmc.c

Zhangfei Gao (2):
  mmc: dw_mmc: change definition of get_cd
  mmc: add dw-mmc-k3

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   66 ++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  392 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c                          |    2 +-
 include/linux/mmc/dw_mmc.h                         |    2 +-
 6 files changed, 471 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5
