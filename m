From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Wed, 16 Jul 2014 16:19:47 +0200
Subject: [PATCH 0/2] mmc: add driver stage register handling
Message-ID: <1405520389-32649-1-git-send-email-list-09_linux_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tq-group.com>

The first patch is taken from Sascha Hauers patch from 25/05/2014
and tries to follow comments from Ulf Hansson. Second patch
adds this feature to the sdhci-esdhc-imx driver which has an own
device tree probe routine. 

Markus Niebel (2):
  mmc: implement driver stage register handling
  mmc: sdhci-esdhc-imx: implement DSR support

 Documentation/devicetree/bindings/mmc/mmc.txt |    7 +++++++
 drivers/mmc/core/host.c                       |    8 ++++++++
 drivers/mmc/core/mmc.c                        |    8 ++++++++
 drivers/mmc/core/mmc_ops.c                    |   17 +++++++++++++++++
 drivers/mmc/core/mmc_ops.h                    |    1 +
 drivers/mmc/core/sd.c                         |    8 ++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c            |   15 +++++++++++++++
 include/linux/mmc/card.h                      |    3 ++-
 include/linux/mmc/host.h                      |    3 +++
 include/linux/platform_data/mmc-esdhc-imx.h   |    4 ++++
 10 files changed, 73 insertions(+), 1 deletion(-)

-- 
1.7.9.5
