From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 May 2015 00:43:55 +0800
Subject: [PATCH 0/2] ARM: sun9i: cubieboard4: Enable USB hosts and LEDs
Message-ID: <1431017037-28331-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This small series enables USB host and LED support on the Cubieboard4.
We already support these on the Optimus, so it's just dts stuff.


Regards
ChenYu


Chen-Yu Tsai (2):
  ARM: dts: sun9i: cubieboard4: Enable USB support
  ARM: dts: sun9i: cubieboard4: Enable LEDs

 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 83 +++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

-- 
2.1.4
