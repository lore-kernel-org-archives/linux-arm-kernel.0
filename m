From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 11 Jul 2018 21:22:31 +0800
Subject: [PATCH 0/2] Misc function enhance to Banana Pi M2 Zero board
Message-ID: <20180711132233.42301-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds two device-tree based function enhancements to the
Banana Pi M2 Zero board.

PATCH 1 adds the HDMI output. (Note: although the connector type is set
to "c" in the device tree, currently sun8i-dw-hdmi doesn't check it and
still set the type to HDMI-A).

PATCH 2 adds VDD-CPUX regulator, and link it to DVFS.

Icenowy Zheng (2):
  ARM: sun8i: h3: enable HDMI output on Banana Pi M2 Zero
  ARM: sun8i: h3: add SY8113B regulator on Banana Pi M2 Zero board

 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

-- 
2.17.1
