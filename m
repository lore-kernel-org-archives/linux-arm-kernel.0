From: girishks2000@gmail.com (girishks2000 at gmail.com)
Date: Tue, 18 Jun 2013 10:30:08 +0530
Subject: [RESEND PATCH v1 0/3] Polling support for s3c64xx spi controller
Message-ID: <51bfe96b.4266420a.3737.3523@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Girish K S <ks.giri@samsung.com>

This patch series adds support for the polling mode only. Also 2nd patch
in the series adds support for dedicated cs pin. After Thomas's patch for
using default gpio is merged(commit id: 00ab539), one of the patch in this
series is dropped and new series is generated.

Girish K S (3):
  spi: s3c64xx: added support for polling mode
  spi: s3c64xx: Added provision for dedicated cs pin
  spi: s3c64xx: Added support for exynos5440 spi

 drivers/spi/spi-s3c64xx.c |  197 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 140 insertions(+), 57 deletions(-)

-- 
1.7.5.4
