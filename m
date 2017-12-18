From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 18 Dec 2017 17:39:00 +0000
Subject: [PATCH v2 0/3] Add CMT support to r8a774[35]
Message-ID: <1513618743-4773-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series adds CMT support for r8a7743 and r8a7745.

Thanks,

Fabrizio Castro (3):
  dt-bindings: timer: renesas, cmt: Document r8a774[35] CMT support
  ARM: dts: r8a7743: Add CMT SoC specific support
  ARM: dts: r8a7745: Add CMT SoC specific support

 .../devicetree/bindings/timer/renesas,cmt.txt      | 14 +++++++---
 arch/arm/boot/dts/r8a7743.dtsi                     | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7745.dtsi                     | 32 ++++++++++++++++++++++
 3 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.7.4
