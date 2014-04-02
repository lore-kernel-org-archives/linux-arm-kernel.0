From: stefan@agner.ch (stefan at agner.ch)
Date: Wed,  2 Apr 2014 19:05:36 +0200
Subject: [PATCH v2 0/2] ARM: dts: fix wrong stmpe-ts bindings
Message-ID: <cover.1396457876.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

I don't have any of these hardware, but the error is obvious. The device
probably works anyway since the device/driver will use default values.

Changes since v1:
- Split patch in two for i.MX/SPEAr

Stefan Agner (2):
  ARM: dts: mx5: fix wrong stmpe-ts bindings
  ARM: dts: SPEAr: fix wrong stmpe-ts bindings

 arch/arm/boot/dts/imx53-m53evk.dts  | 20 ++++++++++----------
 arch/arm/boot/dts/spear1310-evb.dts | 18 +++++++++---------
 arch/arm/boot/dts/spear1340-evb.dts | 18 +++++++++---------
 arch/arm/boot/dts/spear320-hmi.dts  | 20 ++++++++++----------
 4 files changed, 38 insertions(+), 38 deletions(-)

-- 
1.9.1
