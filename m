From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 1 Aug 2017 15:03:28 +0800
Subject: [PATCH 0/5] Add some DT nodes for Mediatek MT2701 
Message-ID: <1501571013-22327-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.13-rc1, include MT2701 ethernet/disp bls/display/usb3 function DT nodes.

Chunfeng Yun (1):
  arm: dts: mt2701: Add usb3 device nodes

Sean Wang (1):
  arm: dts: mt2701: Add ethernet device node

Weiqing Kong (2):
  arm: dts: mt2701: Add display bls related nodes for MT2701
  arm: dts: mt2701: Add display bls related nodes for MT2701

YT Shen (1):
  arm: dts: mt2701: Add display subsystem related nodes for MT2701

 arch/arm/boot/dts/mt2701-evb.dts |  27 ++++++
 arch/arm/boot/dts/mt2701.dtsi    | 189 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+)

--
1.9.1 
