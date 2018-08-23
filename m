From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 23 Aug 2018 09:58:46 +0100
Subject: [PATCH 0/5] Add SYS-DMAC/INTC-EX/[H]SCIF/EAVB/RWDT support
Message-ID: <1535014731-64472-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series aims to add support for SYS-DMAC/INTC-EX/SCIF/HSCIF/
EAVB/RWDT on RZ/G2M SoC dtsi.

THis patch series based on renesas-devel-20180822-v4.18.

Biju Das (3):
  arm64: dts: renesas: r8a774a1: Add SYS-DMAC controller nodes
  arm64: dts: renesas: r8a774a1: Add INTC-EX device node
  arm64: dts: renesas: r8a774a1: Add RWDT node

Fabrizio Castro (2):
  arm64: dts: renesas: r8a774a1: Add SCIF and HSCIF nodes
  arm64: dts: renesas: r8a774a1: Add Ethernet AVB node

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 358 ++++++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)

-- 
2.7.4
