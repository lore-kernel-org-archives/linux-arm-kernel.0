From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Jul 2015 22:56:40 +0800
Subject: [PATCH v2 0/2] ARM: configs: update Allwinner options
Message-ID: <1438354602-6361-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series updates sunxi_defconfig and multi_v7_defconfig with all 
the latest Allwinner additions.

  - DMA_SUN6I, P2WI and PWM were added a few releases back, but never
    got added to the list.
  - EXTCON is required by an updated sun4i USB PHY driver.
  - Allwinner cryptodev (Security System) driver is queued up for 4.3.


v2 adds CGROUPS to sunxi_defconfig, and fixes a typo (crytodev ->
cryptodev) in the second patch.


ChenYu

Chen-Yu Tsai (2):
  ARM: sunxi_defconfig: Enable DMA_SUN6I, P2WI, PWM, cryptodev, EXTCON,
    FHANDLE
  ARM: multi_v7_defconfig: Enable Allwinner P2WI, PWM, DMA_SUN6I,
    cryptodev

 arch/arm/configs/multi_v7_defconfig |  5 +++++
 arch/arm/configs/sunxi_defconfig    | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.5.0
