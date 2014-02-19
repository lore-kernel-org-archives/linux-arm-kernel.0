From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 19 Feb 2014 13:38:39 +0800
Subject: [PATCH 0/4] Add audio card support for Vybird-TWR board
Message-ID: <1392788323-6092-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add audio card support for Vybird-TWR board


Xiubo Li (4):
  ARM: dts: Add Freescale SAI ALSA SoC Digital Audio Interface node for
    VF610.
  ARM: dts: Enable SAI ALSA SoC DAI device for Vybrid VF610 TOWER board.
  ARM: dts: Enable SGTL5000 codec based audio driver node for VF610
    TOWER.
  ARM: dts: Add simple-card support for Vybird-TWR board

 arch/arm/boot/dts/vf610-twr.dts | 68 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi    |  3 ++
 2 files changed, 71 insertions(+)

-- 
1.8.4
