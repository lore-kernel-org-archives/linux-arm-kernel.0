From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 28 Sep 2017 15:07:26 +0200
Subject: [RFC PATCH 0/4] dt-bindings: add bindings for USB physical connector
References: <CGME20170928130734eucas1p299c0e8135df3fb0484d72452cbd2ee47@eucas1p2.samsung.com>
Message-ID: <20170928130730.8747-1-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset introduces USB connector bindings, together with working example.
I have added comments in relevant patches to describe possible issues.

Regards
Andrzej


Andrzej Hajda (3):
  dt-bindings: add bindings for USB physical connector
  arm64: dts: exynos: add micro-USB connector node to TM2 platforms
  extcon: add possibility to get extcon device by of node

Maciej Purski (1):
  drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

 .../bindings/connector/usb-connector.txt           | 49 +++++++++++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 47 ++++++++++-
 drivers/extcon/extcon.c                            | 44 +++++++---
 drivers/gpu/drm/bridge/sil-sii8620.c               | 98 +++++++++++++++++++++-
 include/linux/extcon.h                             |  6 ++
 5 files changed, 228 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

-- 
2.14.1
