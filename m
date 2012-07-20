From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 20 Jul 2012 13:01:46 +0530
Subject: [PATCH v2 0/2] Add pinctrl support to AM33XX family of devices
Message-ID: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds pinctrl support to AM33XX family of devices. These patches were
tested on AM335x-Bone and AM335x-EVM 

Changes from v1:
	- Rebased the patches based on latest pinctrl-single driver

AnilKumar Ch (2):
  arm/dts: Add AM33XX basic pinctrl support
  arm/dts: Configure pinmuxs for user leds control on Bone

 arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |    9 +++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)
