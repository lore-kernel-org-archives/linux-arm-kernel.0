From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Jul 2015 19:12:05 +0800
Subject: [PATCH 0/2] ARM: configs: update Allwinner options
Message-ID: <1438341127-7175-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series updates sunxi_defconfig and multi_v7_defconfig with all 
the latest Allwinner additions.

  - DMA_SUN6I, P2WI and PWM were added a few releases back, but never
    got added to the list.
  - EXTCON is required by an updated sun4i USB PHY driver.
  - Allwinner cryptodev (Security System) driver is queued up for 4.3.

ChenYu

Chen-Yu Tsai (2):
  ARM: sunxi_defconfig: Enable DMA_SUN6I, P2WI, PWM, cryptodev, EXTCON,
    FHANDLE
  ARM: multi_v7_defconfig: Enable Allwinner P2WI, PWM, DMA_SUN6I,
    crytodev

 arch/arm/configs/multi_v7_defconfig | 5 +++++
 arch/arm/configs/sunxi_defconfig    | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.5.0
