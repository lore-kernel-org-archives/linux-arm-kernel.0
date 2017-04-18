From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Apr 2017 14:55:37 +0900
Subject: [PATCH/RFT 0/2] ARM: dts: gose: Enable UHS-I SDR-50 and SDR-104
Message-ID: <1492494939-24568-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable
- SDR-50 and SDR-104 for SDHI0 and;
- SDR-50 for SDHI1

Verified:
- SDR104 for SDHI0
- SDR50 for SDHI1
- Results comprable to those listed for other Renesas R-Car Gen2 boards on
  http://elinux.org/Tests:SD-SDHI-SDR104
Untested:
SDR50 for SDHI3
- HS C4 card present in slot on board which I access remotely


Simon Horman (2):
  ARM: dts: r8a7793: set maximum frequency for SDHI clocks
  ARM: dts: gose: Enable UHS-I SDR-50 and SDR-104

 arch/arm/boot/dts/r8a7793-gose.dts | 34 +++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/r8a7793.dtsi     |  3 +++
 2 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
