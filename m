From: cl@rock-chips.com (cl at rock-chips.com)
Date: Wed, 23 Aug 2017 16:40:29 +0800
Subject: [PATCH v1 0/3] Enable some devices for rk3328 evaluation board
Message-ID: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

1. enalbe sdio/sdmmc/emmc.
2. enable cpufreq.

Liang Chen (3):
  arm64: dts: rockchip: add mmc nodes for rk3328 evaluation board
  cpufreq: rockchip: add support for rk3328 soc
  arm64: dts: rockchip: add cpu regulator for rk3328 evaluation board

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 78 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  1 +
 2 files changed, 79 insertions(+)

-- 
1.9.1
