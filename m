From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 19 Feb 2014 15:42:27 +0800
Subject: [PATCH v2 0/4] Add audio card DT node support for Vybird-TWR board
Message-ID: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add audio card DT node support for Vybird-TWR board.


Xiubo Li (4):
  ARM: dts: vf610: Add edma mux Tx and Rx support for SAI node.
  ARM: dts: vf610-twr: Enable SAI ALSA SoC DAI device
  ARM: dts: vf610-twr: Enable SGTL5000 codec.
  ARM: dts: vf610-twr: Add simple-card support.

 arch/arm/boot/dts/vf610-twr.dts | 71 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi    |  3 ++
 2 files changed, 74 insertions(+)

-- 
1.8.4
