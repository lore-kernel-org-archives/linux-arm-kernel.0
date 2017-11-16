From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 Nov 2017 12:11:28 +0000
Subject: [PATCH 0/2] Add VIN support to r8a7743
Message-ID: <1510834290-25434-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series documents VIN related dt-bindings for r8a774[35], and adds VIN[012]
nodes to the r8a7743 SoC dtsi.

Best regards,

Fabrizio Castro (2):
  dt-bindings: media: rcar_vin: add device tree support for r8a774[35]
  ARM: dts: r8a7743: add VIN dt support

 .../devicetree/bindings/media/rcar_vin.txt         |  5 ++-
 arch/arm/boot/dts/r8a7743.dtsi                     | 36 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.7.4
