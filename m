From: erin.lo@mediatek.com (Erin Lo)
Date: Mon, 26 Jun 2017 15:51:28 +0800
Subject: [PATCH v3 0/4] Add some DT nodes for Mediatek MT2701
Message-ID: <1498463492-24633-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.12-rc1, include MT2701 ethernet/disp bls/display function DT nodes.

Change in v3:
1. Sorting according to name in mt2701-evb.dts
2. Really remove redundant dispsys at 14000000 node

Change in v2:
1. Add reset properties in ethernet nodes
2. Split bls nodes into two patches for dtsi and actual board
3. Remove redundant dispsys at 14000000 node


Sean Wang (1):
  arm: dts: mt2701: Add ethernet device node

Weiqing Kong (2):
  arm: dts: mt2701: Add display bls related nodes for MT2701
  arm: dts: mt2701: Add display bls related nodes for MT2701

YT Shen (1):
  arm: dts: mt2701: Add display subsystem related nodes for MT2701

 arch/arm/boot/dts/mt2701-evb.dts |  27 ++++++++++
 arch/arm/boot/dts/mt2701.dtsi    | 111 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

--
1.9.1
