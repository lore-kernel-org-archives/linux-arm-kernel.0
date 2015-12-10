From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Dec 2015 21:36:28 +0800
Subject: [PATCH 0/3] ARM: dts: sun9i: cubieboard4: Enable misc. peripherals
Message-ID: <1449754591-3999-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here are some patches enabling some peripherals on the Cubieboard4.

Patch 1 enables the LEDs.

Patch 2 enables the IR receiver.

Patch 3 enables the RSB controller.


Regards
ChenYu

Chen-Yu Tsai (3):
  ARM: dts: sun9i: cubieboard4: Enable LEDs
  ARM: dts: sun9i: cubieboard4: Enable consumer IR receiver
  ARM: dts: sun9i: cubieboard4: Enable Reduced Serial Bus controller

 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.6.2
