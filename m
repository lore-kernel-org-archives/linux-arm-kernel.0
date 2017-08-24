From: cl@rock-chips.com (cl at rock-chips.com)
Date: Thu, 24 Aug 2017 10:37:00 +0800
Subject: [PATCH v1 0/3] Enable some devices for rk3328 evaluation board
Message-ID: <1503542223-21044-1-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

1. enalbe sdio/sdmmc/emmc.
2. enable cpufreq.

change in v2:

1. remove useless properties in mmc nodes.

Liang Chen (3):
  arm64: dts: rockchip: add mmc nodes for rk3328 evaluation board
  cpufreq: rockchip: add support for rk3328 soc
  arm64: dts: rockchip: add cpu regulator for rk3328 evaluation board

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 70 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  1 +
 2 files changed, 71 insertions(+)

-- 
1.9.1
