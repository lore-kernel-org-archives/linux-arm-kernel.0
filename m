From: ayaka@soulik.info (Randy Li)
Date: Thu,  7 Jul 2016 01:34:04 +0800
Subject: [PATCH 0/3] Re: [PATCH 2/3] ARM: dts: move regulator settings from
 common to specifics
In-Reply-To: <3015470.z4L7UQJKa9@phil>
References: <3015470.z4L7UQJKa9@phil>
Message-ID: <1467826447-24159-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am sorry to make this mistake. I have re-sent my patches.
Thank you for reminding me that.

I hope that I make it correct this time.

ayaka (3):
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
