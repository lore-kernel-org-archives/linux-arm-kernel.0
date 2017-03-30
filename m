From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 30 Mar 2017 17:50:48 +0800
Subject: [PATCH 0/2] This patches set cros_ec_keyb as a wakeup source,
 so the chromeos's powerd
Message-ID: <1490867450-31765-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

can control the keyboard's wakeup ability along with other ec event sources.


Jeffy Chen (2):
  input: cros_ec_keyb: Report wakeup events
  ARM: dts: cros-ec-keyboard: Enable as wakeup source

 arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
 drivers/input/keyboard/cros_ec_keyb.c   | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
2.1.4
