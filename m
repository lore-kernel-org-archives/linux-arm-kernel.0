From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Fri, 18 Dec 2015 11:49:51 +0300
Subject: [PATCH 0/4] ARM: dts: sun7i: Devicetree improvements for the Wexler
 TAB7200
Message-ID: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,
This is a batch of patches with devicetree improvements for Wexler TAB7200 tablet.

The first one add Goodix GT911 touchscreen node to dts.
The second add PWM node, which need for LCD backlight.
The third add LCD backlight support via PWM.
The last add PA gpio pin for controlling external amplifiers.

The touchscreen patch depends on "Goodix touchscreen enhancements" [1]
and "Input: goodix - add axis swapping and axis inversion support" [2]
patchsets. Both merged into Dmitry Torokhov's input tree (goodix branch)

[1] https://lkml.org/lkml/2015/11/19/241
[2] https://lkml.org/lkml/2015/11/21/44

Aleksei Mamlin (4):
  ARM: dts: sun7i: Enable touchscreen on Wexler TAB7200 tablet
  ARM: dts: sun7i: Enable PWM controller on Wexler TAB7200 tablet
  ARM: dts: sun7i: Add backlight node to Wexler TAB7200 tablet
  ARM: dts: sun7i: Add PA gpio pin to Wexler TAB7200 tablet

 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

-- 
2.4.10
