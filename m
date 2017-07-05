From: biju.das@bp.renesas.com (Biju Das)
Date: Wed,  5 Jul 2017 14:01:49 +0100
Subject: [PATCH v 0/2] Add RZ/G1M (R8A7743) Ethernet AVB support
Message-ID: <1499259711-56175-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add Gigabit Ethernet E-MAC support on r8a7743 (RZ/G1M) SoC.
The iWave RZ/G1M Qseven SOM supports Gigabit Ethernet Phy from Micrel(KSZ9031MNX).
Gigabit Ethernet support is available in Renesas AVB driver.

This series has been tested against linux-next tag next-20170704.

Biju Das (2):
  ravb: Add support for r8a7743 SoC
  ARM: shmobile: defconfig: Enable Ethernet AVB

 Documentation/devicetree/bindings/net/renesas,ravb.txt | 3 ++-
 arch/arm/configs/shmobile_defconfig                    | 1 +
 drivers/net/ethernet/renesas/ravb_main.c               | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1
