From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sat, 20 May 2017 00:35:48 +0300
Subject: [PATCH 0/2] orange-pi-zero: minor updates for board peripherals
Message-ID: <20170519213550.8434-1-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These two patches simplify the use of orange-pi-zero board
right out of the box:

- add interrupt triggering for the on-board XR819 SDIO WiFi chip
- enable on-board SPI NOR

Regards,
Sergey

sun8i-h2-plus-orangepi-zero.dts |   18 ++++++++++++++++++
1 file changed, 18 insertions(+)
