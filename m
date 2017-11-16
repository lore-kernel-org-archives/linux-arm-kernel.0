From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 Nov 2017 18:22:47 +0000
Subject: [PATCH v2 0/4] Add VIN support to r8a774[35]
Message-ID: <1510856571-30281-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series documents VIN related dt-bindings for r8a774[35], adds VIN[012]
nodes to the r8a7743 SoC dtsi and adds VIN[01] nodes to the r8a7745 SoC dtsi.

Best regards,

Fabrizio Castro (4):
  dt-bindings: media: rcar_vin: Reverse SoC part number list
  dt-bindings: media: rcar_vin: add device tree support for r8a774[35]
  ARM: dts: r8a7743: add VIN dt support
  ARM: dts: r8a7745: add VIN dt support

 .../devicetree/bindings/media/rcar_vin.txt         | 19 +++++++-----
 arch/arm/boot/dts/r8a7743.dtsi                     | 36 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7745.dtsi                     | 24 +++++++++++++++
 3 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.7.4
