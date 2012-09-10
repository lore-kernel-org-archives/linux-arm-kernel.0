From: mporter@ti.com (Matt Porter)
Date: Mon, 10 Sep 2012 15:45:10 -0400
Subject: [PATCH v2 0/2] ARM: dts: AM33xx: Correct gpio labels to match docs
Message-ID: <1347306312-31533-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
	- Series now applies on top of Anil's AM33XX DTS series
 
This series applies on top of the for_3.7/dts/ branch and Anil's
"[v7,2/3] arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone"
patch that is part of the overall series adding led and pinctrl DTS data
for AM33xx.

It is intended to correct the current labeling of gpios in the DTS before
too many more drivers are submitted for AM33xx that have gpios not matching
the docs.

Matt Porter (2):
  ARM: dts: AM33XX: fix gpio node numbering to match hardware
  ARM: dts: AM33XX: adjust leds to use the corrected gpio label

 arch/arm/boot/dts/am335x-bone.dts |    8 ++++----
 arch/arm/boot/dts/am33xx.dtsi     |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.7.9.5
