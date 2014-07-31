From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 31 Jul 2014 20:33:13 +0300
Subject: [PATCH 0/2] spi: davinci: add support for gpio cs through dt
Message-ID: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series enables GPIO chip select feature for Davinci SPI
when DT-boot mode is used.
This is actual for Keystone 2 which supports DT-boot mode only.

Murali Karicheri (2):
  spi: davinci: fix to support more than 2 chip selects
  spi: davinci: add support to configure GPIO CS through DT

 .../devicetree/bindings/spi/spi-davinci.txt        |    9 ++-
 drivers/spi/spi-davinci.c                          |   71 +++++++++++++++++---
 2 files changed, 68 insertions(+), 12 deletions(-)

-- 
1.7.9.5
