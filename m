From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Mar 2014 12:37:21 +0100
Subject: [PATCH v3 0/2] i2c: sunxi: Change compatibles pattern
Message-ID: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the third version of the i2c compatible changes.

Changes from v2:
  - rebased on top of current i2c/for-next

Maxime Ripard (2):
  i2c: sunxi: Change i2c compatibles
  ARM: sunxi: dt: Convert to the new i2c compatibles

 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt |  2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                      |  6 +++---
 arch/arm/boot/dts/sun5i-a10s.dtsi                     |  6 +++---
 arch/arm/boot/dts/sun5i-a13.dtsi                      |  6 +++---
 arch/arm/boot/dts/sun7i-a20.dtsi                      | 10 +++++-----
 drivers/i2c/busses/i2c-mv64xxx.c                      |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

-- 
1.9.0
