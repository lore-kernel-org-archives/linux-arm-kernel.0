From: ayaka@soulik.info (Randy Li)
Date: Thu,  7 Jul 2016 01:52:41 +0800
Subject: [PATCH 0/3] Re:[PATCH 2/3] ARM: dts: move regulator settings from
 common to specifics
In-Reply-To: <3015470.z4L7UQJKa9@phil>
References: <3015470.z4L7UQJKa9@phil>
Message-ID: <1467827564-28007-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am very sorry very sorry, the last time I sent are still wrong.
I forget to reset the author. Please drop the below ones,
and have a review on this time.

I am sorry to waste your time.

Randy Li (3):
  ARM: dts: add label leds for rk3288-firefly.dtsi
  ARM: dts: move regulator settings from common to specifics
  ARM: dts: add rk3288-firefly-reload

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/rk3288-firefly-beta.dts   |  30 ++++++++
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 109 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dts        |  30 ++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi       |  16 ++--
 5 files changed, 178 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts

-- 
2.7.4
