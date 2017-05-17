From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed, 17 May 2017 17:52:23 +0800
Subject: [PATCH v2 0/3] add and fix some device node for rk322x SoC
Message-ID: <1495014746-27621-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series of patches fix some device node errors and add watchdog
device node support for rk322x SoC.

Changes from v1:
 - Updated the 'Signed-off-by' tag with original authors' email id.
 - Dropped pinctrl-0 of uart2 emendation.

Frank Wang (2):
  arm: dts: rk322x: correct uart2 pinctrl and add another sets
  arm: dts: rk322x: add watchdog device node.

Sugar Zhang (1):
  arm: dts: rk322x: fix i2s1 pinctrl error

 arch/arm/boot/dts/rk322x.dtsi | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.0.0
