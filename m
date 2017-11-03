From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Fri,  3 Nov 2017 22:58:53 +0300
Subject: [PATCH 0/2] arm64: dts: orange-pi-zero-plus2 mmc and wifi
Message-ID: <20171103195855.15283-1-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables WiFi/BT and fixes sdcard on
orange-pi-zero-plus2 board.

Sergey Matyukevich (2):
 arm64: dts: orange-pi-zero-plus2: fix sdcard detect
 arm64: dts: orange-pi-zero-plus2: enable AP6212a WiFi/BT

 sun50i-h5-orangepi-zero-plus2.dts |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)
