From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 21 Sep 2018 19:08:26 +0100
Subject: [PATCH 0/5] Add Du support to RZ/G1C and RZ/G1N
Message-ID: <1537553311-8831-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

this series documents and adds driver support for the DUs found
inside RZ/G1C (a.k.a. R8A77470) and RZ/G1N (a.k.a. R8A7744).
Also, this series enables the SII902X driver as the SiI9022ACNU
HDMI transmitter is found on the iwg23s.

Thanks,
Fab

Biju Das (2):
  dt-bindings: display: renesas: du: Document the r8a7744 bindings
  drm: rcar-du: Add R8A7744 support

Fabrizio Castro (3):
  dt-bindings: display: renesas: du: Document the r8a77470 bindings
  drm: rcar-du: Add r8a77470 support
  ARM: shmobile: defconfig: Enable SII902X

 .../devicetree/bindings/display/renesas,du.txt     |  4 ++++
 arch/arm/configs/shmobile_defconfig                |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              | 27 ++++++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.7.4
