From: embed3d@gmail.com (Philipp Rossak)
Date: Fri,  1 Sep 2017 18:29:59 +0200
Subject: [PATCH v2 0/2] [DTS] Enable hardware for Nanopi M1 & Nanopi M1 Plus
Message-ID: <1504283401-4263-1-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

This is v2 of my Enable hardware for Nanopi M1 & Nanopi M1 Plus Patchseries.

Changes since v1:

  - removed pincrtl node from power sequence

  - removed vqmmc-supply

  - changed ap6212 label to sdio_wifi

  - removed vqmmc-supply & pincrtl node for powersequence on Bananapi M2 Plus

  - Droped patches for the IR controller & UART that are allready queued for 4.15

  - Droped dwmac-sun8i patches

Original cover letter from v1:

This Patchseries enables the IR controller and the dwmac-sun8i
on the Friendlyarm Nanopi M1 and Friendlyarm Nanopi M1 Plus boards.
On the Nanopi M1 Plus additionally the BT/Wifi module is activated.

Philipp Rossak (2):
  ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1 on Nanopi M1 Plus
  ARM: dts: sun8i: h3: Improved Wifi bindings on Bananapi M2 Plus

 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts |  7 -------
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts   | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.7.4
