From: Eugen.Hristev@microchip.com (Eugen.Hristev at microchip.com)
Date: Wed, 21 Nov 2018 08:47:54 +0000
Subject: [PATCH 0/3] drm: Add panel support for PDA 91-00156-A0
Message-ID: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for PDA (Precision Design Associates, Inc.)
vendor, and for the PDA 91-00156-A0 simple panel, together with the bindings.

The series is on top of http://anongit.freedesktop.org/git/drm/drm.git drm-next
branch.

Cristian Birsan (1):
  dt-bindings: drm/panel: simple: add support for PDA 91-00156-A0

Eugen Hristev (2):
  dt-bindings: add vendor prefix for PDA Precision Design Associates,
    Inc.
  drm/panel: simple: add support for PDA 91-00156-A0 panel

 .../bindings/display/panel/pda,91-00156-a0.txt     |  7 ++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt

-- 
2.7.4
