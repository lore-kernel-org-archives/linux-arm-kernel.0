From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Sep 2012 10:54:16 +0900
Subject: [PATCH 0/2] ARM; shmobile: kzm9g: enable sensors on the board
Message-ID: <1347933258-4372-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a forward of a short patch series by Tetsuyuki Kobayashi
to linux-arm-kernel in preparation for a future pull request.

----------------------------------------------------------------
KZM-A9-GT board (kzm9g) has 2 sensor chip on the board.
 - magnetometer AK8975
 - three-axis digital accelerometer ADXL345
This patch registers device driver and assign I2C slave address and IRQ.

Tetsuyuki Kobayashi (2):
  ARM: shmobile: kzm9g: enable magnetometer ak8975.
  ARM: shmobile: kzm9g: enable three-axis digital accelerometer ADXL345

 arch/arm/configs/kzm9g_defconfig     |    4 ++++
 arch/arm/mach-shmobile/board-kzm9g.c |   10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
1.7.9.5
