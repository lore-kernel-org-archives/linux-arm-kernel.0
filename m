From: erin.lo@mediatek.com (Erin Lo)
Date: Thu, 1 Jun 2017 14:08:41 +0800
Subject: [PATCH 0/3] Add some DT nodes for Mediatek MT2701
Message-ID: <1496297324-21091-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.12-rc1, include MT2701 ethernet/disp bls/display function DT nodes.

Sean Wang (1):
  arm: dts: mt2701: Add ethernet device node

YT Shen (2):
  arm: dts: mt2701: Add display bls related nodes for MT2701
  arm: dts: mt2701: Add display subsystem related nodes for MT2701

 arch/arm/boot/dts/mt2701-evb.dts |  29 ++++++++++
 arch/arm/boot/dts/mt2701.dtsi    | 113 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

--
1.9.1
