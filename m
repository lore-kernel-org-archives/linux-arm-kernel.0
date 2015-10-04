From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Sun,  4 Oct 2015 21:58:45 +0300
Subject: [PATCH 0/3] ARM: dts: sun4i: USB DRC and voltage-scaling for
 pcDuino1/2
Message-ID: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This brings LinkSprite pcDuino1/2 boards up to date with the latest
kernel features. And the first patch in this set is a bugfix for the
PH3/PH6 pins misuse.

There is currently a single dts file for pcDuino1 and pcDuino2 boards.
They obviously had been designed to be compatible with each other, but
have some minor differences, as can be seen when comparing schematics:
    https://s3.amazonaws.com/pcduino/Hardware/PC+Duino_V01-20130128.pdf
    https://s3.amazonaws.com/pcduino/Hardware/v2/pcDuino_v2_sch.pdf

Siarhei Siamashka (3):
  ARM: dts: sun4i: Allow to use the PH6 pin for GPIO on pcDuino1/2
  ARM: dts: sun4i: Enable USB DRC on pcDuino1/2
  ARM: dts: sun4i: Add AXP209 PMU regulators for pcDuino1/2

 arch/arm/boot/dts/sun4i-a10-pcduino.dts | 56 +++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 10 deletions(-)

-- 
2.4.9
