From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 11:56:30 +0100
Subject: [PATCH  0/3] Add SMP support
Message-ID: <1502189793-59679-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add SMP support for r8a7743 SoC.

This series has been tested against Linux-next tag 20170727
and renesas-dev branch.

Biju Das (3):
  dt-bindings: apmu: Document r8a7743 support
  ARM: dts: r8a7743: Add APMU node and second CPU core
  ARM: dts: r8a7743: Add OPP table for frequency scaling

 .../devicetree/bindings/power/renesas,apmu.txt     |  3 ++-
 arch/arm/boot/dts/r8a7743.dtsi                     | 25 ++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

-- 
1.9.1
