From: girishks2000@gmail.com (Girish K S)
Date: Fri, 21 Jun 2013 11:26:11 +0530
Subject: [PATCH 0/2] support for non-gpio cs pin
Message-ID: <1371794173-27266-1-git-send-email-ks.giri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the dedicated cs pin and
support for exynos5440 spi controller. The first patch
"Polling support for s3c64xx spi controller" in the previous
serias is already applied to Mark's spi-next branch. So created
a new series with remaining 2 patches.


Girish K S (2):
  spi: s3c64xx: Added provision for dedicated cs pin
  spi: s3c64xx: Added support for exynos5440 spi

 drivers/spi/spi-s3c64xx.c |   46 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 38 insertions(+), 8 deletions(-)

-- 
1.7.5.4
