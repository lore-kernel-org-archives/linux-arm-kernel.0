From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 10 Sep 2018 12:53:47 +0100
Subject: [PATCH 0/3] Add basic definitions for RZ/G2E
Message-ID: <1536580430-17432-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

this series adds basic identification for the RZ/G2E (a.k.a.
r8a774c0).

It applies on top of renesas-devel-20180906-v4.19-rc2.

Thanks,
Fab

Fabrizio Castro (3):
  dt-bindings: arm: Document RZ/G2E SoC DT bindings
  arm64: Add Renesas R8A774C0 support
  soc: renesas: Identify RZ/G2E

 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 arch/arm64/Kconfig.platforms                       | 6 ++++++
 drivers/soc/renesas/renesas-soc.c                  | 8 ++++++++
 3 files changed, 16 insertions(+)

-- 
2.7.4
