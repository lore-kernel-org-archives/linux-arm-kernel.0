From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Apr 2017 12:22:02 +0800
Subject: [PATCH 0/3] ARM: sun8i: a83t: device tree cleanup
Message-ID: <20170418042205.27894-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here are a few patches cleaning up sun8i-a83t.dtsi. These get rid
of known warnings and deprecated features. I'm sending these now
before I send patches that add new stuff.

Regards
ChenYu

Chen-Yu Tsai (3):
  ARM: sun8i: a83t: Drop skeleton.dtsi
  ARM: sun8i: a83t: Drop leading zeroes from device node addresses
  ARM: sun8i: a83t: Rename pinmux setting names

 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |  2 +-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |  2 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 36 ++++++++++++++--------
 3 files changed, 25 insertions(+), 15 deletions(-)

-- 
2.11.0
