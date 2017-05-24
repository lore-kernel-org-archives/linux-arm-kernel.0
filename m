From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Thu, 25 May 2017 00:24:31 +0300
Subject: [PATCH v2 0/2] orange-pi-zero: minor updates for peripherals
Message-ID: <20170524212433.14386-1-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches simplify the use of orange-pi-zero board
right out of the box:
- specify interrupts for the on-board XR819 SDIO WiFi chip
- add node on-board SPI NOR

Changes from v1:
- update commit messages: drop links to wiki at linux-sunxi.org
- disable SPI NOR flash by default
- drop description of the flash partitions
- add compatible property for XR819 wifi node

sun8i-h2-plus-orangepi-zero.dts |   16 ++++++++++++++++
1 file changed, 16 insertions(+)
