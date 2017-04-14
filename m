From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 14 Apr 2017 14:19:36 +0900
Subject: [PATCH 0/3] Add support for the S6E3HA2 edge panel on TM2e board
References: <CGME20170414051958epcas5p379f82e72e9239fdea0b99de88c4c39f1@epcas5p3.samsung.com>
Message-ID: <1492147179-7824-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this patch is add support for S6E3HA2 edge AMOLED panel
on the TM2e board. The panel has 1600x2560 resolution in 5.65"
physical panel in the TM2e device.

The S6E3HA2 edge panel(5.65") is simliar to the previous S6E3HA2
panel(5.7"), but resolution and some command message are different. So
it can be distinguished as a compatiblitiy string.

Best regards,
Hoegeun

Hoegeun Kwon (3):
  dt-bindings: Add support for samsung s6e3ha2 edge panel binding
  drm/panel: s6e3ha2: Add support for S6eHEA2 edge panel on TM2e board
  arm64: dts: exynos: Add support for S6E3HA2 edge panel device on TM2e
    board

 .../bindings/display/panel/samsung,s6e3ha2-e.txt   | 28 ++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     | 12 +++++
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      | 62 +++++++++++++++++++---
 3 files changed, 96 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2-e.txt

-- 
1.9.1
