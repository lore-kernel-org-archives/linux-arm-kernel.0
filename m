From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 21 Dec 2016 11:10:28 +0100
Subject: [PATCH 0/2] Cosmetic changes for the SPI driver of ARMADA 3700
Message-ID: <20161221101030.10925-1-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches fixes coding style issues reported by checkpatch.pl, then it
includes a second patch that replaces raw values by standardized macro constants.

Romain Perier (2):
  spi: armada-3700: Coding style fixes
  spi: armada-3700: Replaced raw values for nbits by the SPI macros

 drivers/spi/spi-armada-3700.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.9.3
