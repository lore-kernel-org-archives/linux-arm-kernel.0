From: m.purski@samsung.com (Maciej Purski)
Date: Thu, 10 Aug 2017 15:25:28 +0200
Subject: [PATCH 0/2] drm/bridge/sii8620: add external connector handle
References: <CGME20170810132549eucas1p29ada94088da5d7d395e95aded77b906f@eucas1p2.samsung.com>
Message-ID: <1502371530-32260-1-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone, 

These patches add external connector handling to sii8620 driver.

The first patch documents the extcon binding and add extcon handling 
to the driver. The second adds support for this in exynos5433-tm2-common.dtsi.

All comments are welcome.

Regards,
Maciej Purski

Patch summary:

Maciej Purski (2):
  drm/bridge/sii8620: add external connector handle
  arm64: dts: exynos: add extcon phandle

 .../bindings/display/bridge/sil-sii8620.txt        |  4 ++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  1 +
 drivers/gpu/drm/bridge/sil-sii8620.c               | 83 +++++++++++++++++++++-
 3 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.7.4
