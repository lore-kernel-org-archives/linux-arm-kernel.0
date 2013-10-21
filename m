From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 21 Oct 2013 15:13:57 +0800
Subject: [v2 PATCH 0/2] mmc: dw_mmc: add dw_mmc-k3
Message-ID: <1382339639-16764-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Follow Jaehoon's suggestion
Use slot-gpio.c handle cd pin
Move table out to dts
other suggestion

Zhangfei Gao (2):
  mmc: dw_mmc: add dw_mci_of_get_cd_gpio to handle cd pin
  mmc: dw_mmc: add dw_mmc-k3 for k3 platform

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   77 +++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  298 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c                          |   34 +++
 5 files changed, 420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5
