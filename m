From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 5 Jul 2012 14:43:34 +0530
Subject: [PATCH 0/2] Add pinctrl support to AM33XX family of devices
Message-ID: <1341479616-18630-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds pinctrl support to AM33XX family of devices. This patch is
based on the pinctrl-simple driver submitted by Tony L
here: http://lwn.net/Articles/496075/

These patches were tested on AM335x-Bone and AM335x-EVM

AnilKumar Ch (2):
  arm/dts: Add AM33XX basic pinctrl support
  arm/dts: Configure pinmuxs for user leds control on Bone

 arch/arm/boot/dts/am335x-bone.dts |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   12 ++++++++++++
 2 files changed, 36 insertions(+)

-- 
1.7.9.5
