From: ayaka@soulik.info (Randy Li)
Date: Tue, 20 Sep 2016 03:02:49 +0800
Subject: [RFC PATCH v3 0/2] adding panel claa070wp03xg support for exynos
Message-ID: <1474311771-23321-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timings issue is still here, this version is just some modifications
in dts file.

Randy Li (2):
  ARM: dts: samsung: add rga-lvds panel in itop elite
  drm/panel: Add support for Chunghwa CLAA070WP03XG panel

 .../display/panel/chunghwa,claa070wp03xg.txt       |  7 +++
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 54 +++++++++++++++++++++-
 drivers/gpu/drm/panel/panel-simple.c               | 27 +++++++++++
 3 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/chunghwa,claa070wp03xg.txt

-- 
2.7.4
