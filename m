From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 29 May 2015 16:56:41 +0200
Subject: [PATCH 0/2] spi: atmel: add support to FIFOs and the internal
 chip-select
Message-ID: <cover.1432910696.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches add support to features introduced by the Atmel sama5d2x
SoC.

Cyrille Pitchen (2):
  spi: atmel: add support for the internal chip-select of the spi
    controller
  spi: atmel: add support to FIFOs

 drivers/spi/spi-atmel.c | 276 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 257 insertions(+), 19 deletions(-)

-- 
1.8.2.2
