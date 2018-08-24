From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 24 Aug 2018 11:43:46 +0100
Subject: [PATCH 0/3] Add USB support
Message-ID: <1535107429-5458-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series aims to add USB2.0/USB3.0 Host/Function support
for RZ/G2M SoC. RZ/G2M SoC is similar to R-Car Gen3 M3-W SoC.

---
This patch series depend on
https://patchwork.kernel.org/patch/10574109/
---

Biju Das (3):
  arm64: dts: renesas: r8a774a1: Add USB2.0 phy and host(EHCI/OHCI)
    device nodes
  arm64: dts: renesas: r8a774a1: Add USB-DMAC and HSUSB device nodes
  arm64: dts: renesas: r8a774a1: Add USB3.0 device nodes

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 153 ++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

-- 
2.7.4
