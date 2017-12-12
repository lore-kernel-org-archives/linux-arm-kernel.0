From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 12 Dec 2017 18:49:36 +0000
Subject: [PATCH 0/3] Add CMT support to r8a774[35]
Message-ID: <1513104579-6333-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds CMT support for r8a7743 and r8a7745.

Thanks,

Fabrizio Castro (3):
  dt-bindings: timer: renesas, cmt: Document r8a774[35] CMT support
  ARM: dts: r8a7743: Add CMT SoC specific support
  ARM: dts: r8a7745: Add CMT SoC specific support

 .../devicetree/bindings/timer/renesas,cmt.txt      | 12 ++++++---
 arch/arm/boot/dts/r8a7743.dtsi                     | 30 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7745.dtsi                     | 30 ++++++++++++++++++++++
 3 files changed, 69 insertions(+), 3 deletions(-)

-- 
2.7.4
