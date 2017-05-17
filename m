From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed, 17 May 2017 11:40:48 +0800
Subject: [PATCH 0/3] add and fix some device node for rk322x SoC
Message-ID: <1494992451-32542-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series of patches fix some device node errors and add watchdog
device node support for rk322x SoC.

Frank Wang (2):
  arm: dts: rk322x: correct uart2 pinctrl and add another sets
  arm: dts: rk322x: add watchdog device node.

Sugar Zhang (1):
  arm: dts: rk322x: fix i2s1 pinctrl error

 arch/arm/boot/dts/rk322x.dtsi | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.0.0
