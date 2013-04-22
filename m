From: girishks2000@gmail.com (Girish K S)
Date: Mon, 22 Apr 2013 12:39:22 +0530
Subject: [PATCH 0/3] Polling support for s3c64xx spi controller
Message-ID: <1366614565-3743-1-git-send-email-ks.giri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the polling mode only. Also 2nd patch
in the series adds support for dedicated cs pin. After Thomas's patch for
using default gpio is merged(commit id: 00ab539), one of the patch in this
series is dropped and new series is generated.

Girish K S (3):
  spi: s3c64xx: added support for polling mode
  spi: s3c64xx: Added provision for dedicated cs pin
  spi: s3c64xx: Added support for exynos5440 spi

 drivers/spi/spi-s3c64xx.c |  192 +++++++++++++++++++++++++++++++-------------
 1 files changed, 135 insertions(+), 57 deletions(-)

-- 
1.7.5.4
