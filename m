From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  9 Sep 2014 13:25:59 +0200
Subject: [PATCH 0/4] ARM: dts: several updates for the imx28-tx28.dts file
Message-ID: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- remove unused labels on spidev nodes
- add third spidev node to utilize all available CS
- use GPIO polarity flags
- add configuration for spi-gpio driver as alternative to spi-mxs
- add an alias for the can transceiver regulator which is used by U-Boot
