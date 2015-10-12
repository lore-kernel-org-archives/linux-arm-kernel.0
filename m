From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 13 Oct 2015 02:54:00 +0300
Subject: [PATCH 0/5] arm: dts: lpc32xx: fixes and updates to lpc32xx.dtsi
Message-ID: <1444694045-22000-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changeset fixes two problems in lpc32xx.dtsi:
- misusage of ranges property,
- improper description of two separate PWM controllers under one
  device node

and adds a number of lesser clean-ups and improvements.

Vladimir Zapolskiy (5):
  arm: dts: lpc32xx: change include syntax to be C preprocessor friendly
  arm: dts: lpc32xx: fix improper usage of ranges property
  arm: dts: lpc32xx: add labels to all defined peripheral nodes
  arm: dts: lpc32xx: remove unneeded cell settings from cpus
  arm: dts: lpc32xx: add device node for the second pwm controller

 arch/arm/boot/dts/ea3250.dts   |  2 +-
 arch/arm/boot/dts/lpc32xx.dtsi | 41 ++++++++++++++++++++++-------------------
 arch/arm/boot/dts/phy3250.dts  |  2 +-
 3 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.1.4
