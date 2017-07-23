From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sun, 23 Jul 2017 16:49:48 +0200
Subject: [linux-sunxi][PATCH 0/2] Beelink X2 updates
Message-ID: <20170723144950.29330-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi all,
as support for sun8i H3 usb otg and ethernet patches has made it into mainline
then these patches extend the functionality of the device.
BR,
CK 

Marcus Cooper (2):
  ARM: dts: sun8i: h3: Enable USB OTG on the Beelink X2
  ARM: dts: sun8i: h3: Enable dwac-sun8i on the Beelink X2

 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 32 +++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

-- 
2.13.3
