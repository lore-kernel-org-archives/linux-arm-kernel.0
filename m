From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Jul 2017 15:10:31 +0200
Subject: [PATCH 0/3] Misc updates for Armada 7K/8K CP110 DT description
Message-ID: <20170718131034.25167-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are a few updates to the CP110 DT description. The first one is
really a fix, the next two are just improvements.

Thanks!

Thomas

Thomas Petazzoni (3):
  arm64: dts: marvell: use ICU for the CP110 slave RTC
  arm64: dts: marvell: re-order RTC nodes in Marvell CP110 description
  arm64: dts: marvell: add description for SDHCI controller in CP110
    slave

 .../boot/dts/marvell/armada-cp110-master.dtsi      | 14 ++++++-------
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 24 +++++++++++++++-------
 2 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.9.4
