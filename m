From: christophe.roullier@st.com (Christophe Roullier)
Date: Fri, 25 May 2018 09:46:37 +0200
Subject: [PATCH V0:net-next 0/4] net: ethernet: stmmac: add support for
 stm32mp1
Message-ID: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches to have Ethernet support on stm32mp1

Christophe Roullier (4):
  net: ethernet: stmmac: add adaptation for stm32mp157c.
  dt-bindings: stm32-dwmac: add support of MPU families
  net: stmmac: add dwmac-4.20a compatible
  dt-bindings: stm32: add compatible for syscon

 .../devicetree/bindings/arm/stm32/stm32-syscon.txt |  14 ++
 .../devicetree/bindings/arm/{ => stm32}/stm32.txt  |   0
 .../devicetree/bindings/net/stm32-dwmac.txt        |  18 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 267 +++++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +-
 5 files changed, 284 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
 rename Documentation/devicetree/bindings/arm/{ => stm32}/stm32.txt (100%)

-- 
1.9.1
