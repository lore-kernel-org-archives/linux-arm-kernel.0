From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 Dec 2015 21:59:03 +0530
Subject: [PATCH v2 0/2] spi: davinci: fix spurious i/o error
Message-ID: <cover.1449764266.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes a spurious I/O error with
DaVinci SPI.

v2:
- Update to handle DMA case
- add a patch to use dev_err() for error reporting

Sekhar Nori (2):
  spi: davinci: fix spurious i/o error
  spi: davinci: use dev_err() for error reporting

 drivers/spi/spi-davinci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.6.3
